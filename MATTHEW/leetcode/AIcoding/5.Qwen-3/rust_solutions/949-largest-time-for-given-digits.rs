impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn largest_time_from_digits(arr: Vec<i32>) -> String {
        let mut max_time = -1;
        let digits: Vec<char> = arr.iter().map(|&d| (b'0' + d as u8) as char).collect();

        for i in 0..4 {
            for j in 0..4 {
                if j == i { continue; }
                for k in 0..4 {
                    if k == i || k == j { continue; }
                    for l in 0..4 {
                        if l == i || l == j || l == k { continue; }

                        let hour = digits[i] as i32 * 10 + digits[j] as i32;
                        let minute = digits[k] as i32 * 10 + digits[l] as i32;

                        if hour < 24 && minute < 60 {
                            let time = hour * 60 + minute;
                            max_time = std::cmp::max(max_time, time);
                        }
                    }
                }
            }
        }

        if max_time == -1 {
            return "".to_string();
        }

        let hours = max_time / 60;
        let minutes = max_time % 60;
        format!("{:02}:{:02}", hours, minutes)
    }
}
}