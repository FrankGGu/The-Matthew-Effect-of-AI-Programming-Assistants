impl Solution {

use std::cmp::max;

impl Solution {
    pub fn maximum_score(nums: Vec<i32>, multipliers: Vec<i32>) -> i32 {
        let n = nums.len();
        let m = multipliers.len();
        let mut dp = vec![vec![0; m + 1]; m + 1];

        for i in 0..m {
            for j in 0..=i {
                let k = i - j;
                if j == 0 {
                    dp[j][k] = dp[j][k - 1] + nums[k] * multipliers[i];
                } else if k == 0 {
                    dp[j][k] = dp[j - 1][k] + nums[n - j] * multipliers[i];
                } else {
                    dp[j][k] = max(
                        dp[j - 1][k] + nums[n - j] * multipliers[i],
                        dp[j][k - 1] + nums[k] * multipliers[i]
                    );
                }
            }
        }

        let mut result = 0;
        for j in 0..=m {
            let k = m - j;
            if k >= 0 {
                result = max(result, dp[j][k]);
            }
        }

        result
    }
}
}