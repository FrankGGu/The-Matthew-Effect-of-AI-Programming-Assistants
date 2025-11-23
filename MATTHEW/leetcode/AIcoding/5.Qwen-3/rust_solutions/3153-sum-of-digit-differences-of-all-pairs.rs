impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn sum_digit_diffs(nums: Vec<i32>) -> i64 {
        let n = nums.len();
        let mut total = 0;
        let mut count = vec![HashMap::new(); 10];

        for &num in &nums {
            let s = num.to_string();
            for (i, c) in s.chars().enumerate() {
                let digit = c as u8 - b'0';
                *count[i].entry(digit).or_insert(0) += 1;
            }
        }

        for i in 0..10 {
            let mut sum = 0;
            for &v in count[i].values() {
                sum += v * (v - 1);
            }
            total += sum;
        }

        total as i64
    }
}
}