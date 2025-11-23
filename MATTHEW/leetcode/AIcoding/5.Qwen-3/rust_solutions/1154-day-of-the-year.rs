impl Solution {

use std::str::FromStr;

struct Solution;

impl Solution {
    pub fn day_of_year(date: String) -> i32 {
        let parts: Vec<&str> = date.split('-').collect();
        let year = i32::from_str(parts[0]).unwrap();
        let month = i32::from_str(parts[1]).unwrap();
        let day = i32::from_str(parts[2]).unwrap();

        let leap = if year % 4 == 0 {
            if year % 100 == 0 {
                year % 400 == 0
            } else {
                true
            }
        } else {
            false
        };

        let mut days_in_month = vec![31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
        if leap {
            days_in_month[1] = 29;
        }

        let mut total_days = 0;
        for m in 0..(month - 1) {
            total_days += days_in_month[m as usize];
        }
        total_days + day
    }
}
}