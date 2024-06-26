#!/usr/bin/env bash

# date range, the last day to download will `end_date - 1 day`
start_date=2022-08-01
end_date=2022-09-01

# after this, start_date and end_date will be valid ISO 8601 dates,
start_date=$(gdate -I -d "$start_date") || exit 1
end_date=$(gdate -I -d "$end_date") || exit 1

pushd ./data

current_date="$start_date"
while [ "$current_date" != "$end_date" ]; do 
    echo Downloading $current_date

    file_date=$(gdate -d "$current_date" +"%Y%m%d")

    # CO
    data_file="TROPESS_CrIS-JPSS1_L2_Summary_CO_${file_date}_MUSES_R1p17_FS_F0p6.nc"
    wget --load-cookies ~/.urs_cookies --save-cookies ~/.urs_cookies \
         --auth-no-challenge=on --keep-session-cookies --content-disposition --continue \
        https://tropess.gesdisc.eosdis.nasa.gov/data/TROPESS_Summary/TRPSYL2COCRS1FS.1/2022/$data_file

    # NH3
    data_file="TROPESS_CrIS-JPSS1_L2_Summary_NH3_${file_date}_MUSES_R1p17_FS_F0p6.nc"
    wget --load-cookies ~/.urs_cookies --save-cookies ~/.urs_cookies \
         --auth-no-challenge=on --keep-session-cookies --content-disposition --continue \
        https://tropess.gesdisc.eosdis.nasa.gov/data/TROPESS_Summary/TRPSYL2NH3CRS1FS.1/2022//$data_file

    # PAN
    data_file="TROPESS_CrIS-JPSS1_L2_Summary_PAN_${file_date}_MUSES_R1p17_FS_F0p6.nc"
    wget --load-cookies ~/.urs_cookies --save-cookies ~/.urs_cookies \
         --auth-no-challenge=on --keep-session-cookies --content-disposition --continue\
        https://tropess.gesdisc.eosdis.nasa.gov/data/TROPESS_Summary/TRPSYL2PANCRS1FS.1/2022/$data_file
    

    # advance to next date
    current_date=$(gdate -I -d "$current_date + 1 day")
done

popd
