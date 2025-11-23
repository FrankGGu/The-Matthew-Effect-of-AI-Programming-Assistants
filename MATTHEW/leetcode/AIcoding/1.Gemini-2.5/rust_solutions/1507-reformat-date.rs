impl Solution {
    pub fn reformat_date(date: String) -> String {
        let parts: Vec<&str> = date.split_whitespace().collect();
        let day_str = parts[0];
        let month_str = parts[1];
        let year_str = parts[2];

        let year = year_str;

        let month_num = match month_str {
            "Jan" => "01",
            "Feb" => "02",
            "Mar" => "03",
            "Apr" => "04",
            "May" => "05",
            "Jun" => "06",
            "Jul" => "07",
            "Aug" => "08",
            "Sep" => "09",
            "Oct" => "10",
            "Nov" => "11",
            "Dec" => "12",
            _ => unreachable!(),
        };

        let day_numeric_str = &day_str[..day_str.len() - 2];
        let day: u8 = day_numeric_str.parse().unwrap();
        let formatted_day = format!("{:02}", day);

        format!("{}-{}-{}", year, month_num, formatted_day)
    }
}