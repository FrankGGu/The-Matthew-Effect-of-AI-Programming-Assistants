impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn max_score(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut dp = vec![0; n];
        dp[0] = nums[0];

        for i in 1..n {
            let mut max_val = i32::MIN;
            for j in 0..i {
                if (i as i32 - j as i32) <= nums[j] {
                    max_val = max_val.max(dp[j]);
                }
            }
            dp[i] = max_val + nums[i];
        }

        dp[n - 1]
    }
}
}