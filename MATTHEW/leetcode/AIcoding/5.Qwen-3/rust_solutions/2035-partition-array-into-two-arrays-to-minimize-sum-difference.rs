impl Solution {

use std::cmp::Ordering;

struct Solution {}

impl Solution {
    pub fn minimum_difference(nums: Vec<i32>, k: i32) -> i32 {
        let mut nums = nums;
        nums.sort();
        let n = nums.len();
        let k = k as usize;
        let mut dp = vec![vec![0; k + 1]; n];

        for i in 0..n {
            dp[i][0] = 0;
        }

        for j in 1..=k {
            for i in (j - 1)..n {
                if j == 1 {
                    dp[i][j] = nums[i] - nums[0];
                } else {
                    dp[i][j] = i32::MAX;
                    for m in (j - 2)..i {
                        dp[i][j] = dp[i][j].min(dp[m][j - 1] + nums[i] - nums[m + 1]);
                    }
                }
            }
        }

        dp[n - 1][k]
    }
}
}