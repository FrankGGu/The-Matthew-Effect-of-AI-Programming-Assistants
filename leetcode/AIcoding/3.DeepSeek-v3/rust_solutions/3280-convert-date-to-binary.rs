impl Solution {
    pub fn date_to_binary(date: String) -> String {
        let parts: Vec<&str> = date.split('-').collect();
        let year = parts[0].parse::<u16>().unwrap();
        let month = parts[1].parse::<u8>().unwrap();
        let day = parts[2].parse::<u8>().unwrap();

        let year_binary = format!("{:016b}", year);
        let month_binary = format!("{:04b}", month);
        let day_binary = format!("{:05b}", day);

        format!("{}{}{}", year_binary, month_binary, day_binary)
    }
}