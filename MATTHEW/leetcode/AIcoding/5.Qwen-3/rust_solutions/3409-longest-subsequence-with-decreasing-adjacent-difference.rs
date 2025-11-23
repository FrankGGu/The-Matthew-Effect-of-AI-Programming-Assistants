impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn longest_decreasing_subsequence(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut dp = vec![1; n];

        for i in 0..n {
            for j in 0..i {
                if nums[j] - nums[i] > 0 && dp[j] + 1 > dp[i] {
                    dp[i] = dp[j] + 1;
                }
            }
        }

        *dp.iter().max().unwrap()
    }
}
}