impl Solution {

use std::collections::BTreeSet;

impl Solution {
    pub fn maximize_score(nums: Vec<i32>, multipliers: Vec<i32>) -> i32 {
        let n = nums.len();
        let m = multipliers.len();
        let mut dp = vec![vec![0; m + 1]; m + 1];

        for i in 0..m {
            for j in 0..m {
                if i + j >= n {
                    break;
                }
                let k = i + j;
                let left = nums[i] * multipliers[k];
                let right = nums[n - 1 - j] * multipliers[k];
                dp[i + 1][j] = dp[i][j].max(left);
                dp[i][j + 1] = dp[i][j].max(right);
            }
        }

        let mut max_score = 0;
        for i in 0..=m {
            max_score = max_score.max(dp[i][m - i]);
        }
        max_score
    }
}
}