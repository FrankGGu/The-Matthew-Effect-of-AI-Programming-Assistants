impl Solution {

use std::str::FromStr;

struct Solution;

impl Solution {
    pub fn reformat_date(date: String) -> String {
        let parts: Vec<&str> = date.split_whitespace().collect();
        let day = parts[0].trim_end_matches(|c: char| !c.is_ascii_digit()).parse::<u8>().unwrap();
        let month = match parts[1] {
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
            _ => "",
        };
        let year = parts[2];
        format!("{}-{}-{:02}", year, month, day)
    }
}
}