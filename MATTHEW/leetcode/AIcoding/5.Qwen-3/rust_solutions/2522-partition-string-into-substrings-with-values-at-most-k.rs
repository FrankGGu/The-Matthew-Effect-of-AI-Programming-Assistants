impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn min_partitions(s: String, k: i32) -> i32 {
        let mut result = 0;
        let mut current = 0;

        for c in s.chars() {
            let digit = c as i32 - '0' as i32;

            match digit.cmp(&k) {
                Ordering::Less => {
                    current = current * 10 + digit;
                },
                Ordering::Equal => {
                    result += 1;
                    current = 0;
                },
                Ordering::Greater => {
                    result += 1;
                    current = digit;
                }
            }
        }

        if current > 0 {
            result += 1;
        }

        result
    }
}
}