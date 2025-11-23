impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn count_subarrays(nums: Vec<i32>, k: i32) -> i64 {
        let mut count = HashMap::new();
        let mut res = 0;
        let mut balance = 0;
        count.insert(0, 1);

        for &num in &nums {
            if num > k {
                balance += 1;
            } else if num < k {
                balance -= 1;
            }

            res += *count.get(&balance).unwrap_or(&0);
            *count.entry(balance).or_insert(0) += 1;
        }

        res as i64
    }
}

struct Solution;
}