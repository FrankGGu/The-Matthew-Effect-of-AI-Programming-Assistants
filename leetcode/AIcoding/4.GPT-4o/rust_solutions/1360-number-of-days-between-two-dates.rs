use std::time::SystemTime;
use chrono::{NaiveDate, Datelike};

impl Solution {
    pub fn days_between_dates(date1: String, date2: String) -> i32 {
        let date1 = NaiveDate::parse_from_str(&date1, "%Y-%m-%d").unwrap();
        let date2 = NaiveDate::parse_from_str(&date2, "%Y-%m-%d").unwrap();
        (date1 - date2).num_days().abs() as i32
    }
}