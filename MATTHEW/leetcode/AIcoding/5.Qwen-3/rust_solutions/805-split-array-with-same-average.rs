impl Solution {

use std::cmp::Ordering;
use std::collections::HashMap;

impl Solution {
    pub fn split_array_same_average(nums: Vec<i32>) -> bool {
        let n = nums.len();
        if n == 1 {
            return false;
        }

        let sum: i32 = nums.iter().sum();

        let mut dp = vec![false; n + 1];
        dp[0] = true;

        for &num in &nums {
            for i in (1..=n).rev() {
                if dp[i - 1] {
                    dp[i] = true;
                }
            }
        }

        for i in 1..n {
            if dp[i] && sum * i as i32 == sum * i as i32 * 2 {
                return true;
            }
        }

        false
    }
}
}