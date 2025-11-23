impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn compare_version_numbers(version1: String, version2: String) -> i32 {
        let v1_parts: Vec<&str> = version1.split('.').collect();
        let v2_parts: Vec<&str> = version2.split('.').collect();

        let max_len = std::cmp::max(v1_parts.len(), v2_parts.len());

        for i in 0..max_len {
            let v1_num = match v1_parts.get(i) {
                Some(s) => s.parse::<i32>().unwrap_or(0),
                None => 0,
            };
            let v2_num = match v2_parts.get(i) {
                Some(s) => s.parse::<i32>().unwrap_or(0),
                None => 0,
            };

            match v1_num.cmp(&v2_num) {
                Ordering::Less => return -1,
                Ordering::Greater => return 1,
                Ordering::Equal => continue,
            }
        }

        0
    }
}

pub struct Solution;
}