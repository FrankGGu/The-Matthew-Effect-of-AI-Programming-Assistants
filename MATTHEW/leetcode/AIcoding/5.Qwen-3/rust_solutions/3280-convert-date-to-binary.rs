impl Solution {

use std::fmt::Write;

impl Solution {
    pub fn convert_date_to_binary(date: String) -> String {
        let parts: Vec<&str> = date.split('-').collect();
        let year = parts[0].parse::<u32>().unwrap();
        let month = parts[1].parse::<u32>().unwrap();
        let day = parts[2].parse::<u32>().unwrap();

        let mut result = String::new();
        write!(&mut result, "{}", format!("{:b}-", year)).unwrap();
        write!(&mut result, "{}", format!("{:b}-", month)).unwrap();
        write!(&mut result, "{}", format!("{:b}", day)).unwrap();

        result
    }
}

pub struct Solution;
}