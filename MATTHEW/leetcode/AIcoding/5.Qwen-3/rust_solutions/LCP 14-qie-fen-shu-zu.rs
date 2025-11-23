impl Solution {

use std::cmp;

impl Solution {
    pub fn split_array(nums: Vec<i32>, m: i32) -> i32 {
        let m = m as usize;
        let n = nums.len();
        let mut dp = vec![0; n + 1];
        for i in 1..=n {
            dp[i] = dp[i - 1] + nums[i - 1];
        }
        for i in 1..=m {
            let mut new_dp = vec![i32::MAX; n + 1];
            for j in i..=n {
                for k in i - 1..j {
                    new_dp[j] = cmp::min(new_dp[j], cmp::max(dp[k] - dp[i - 1], new_dp[k]));
                }
            }
            dp = new_dp;
        }
        dp[n]
    }
}
}