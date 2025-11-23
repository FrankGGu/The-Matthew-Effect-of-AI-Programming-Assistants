impl Solution {

use std::cmp::Ordering;
use std::collections::BinaryHeap;

struct Solution;

impl Solution {
    pub fn max_total_space_wasted(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let k = k as usize;
        let mut dp = vec![vec![0; n]; k + 1];
        let mut prefix = vec![0; n + 1];

        for i in 0..n {
            prefix[i + 1] = prefix[i] + nums[i];
        }

        for i in 0..n {
            for j in 0..=k {
                if j == 0 {
                    dp[j][i] = prefix[i + 1] - prefix[0] - nums[i] * (i + 1) as i32;
                } else {
                    dp[j][i] = i32::MAX;
                    for m in 0..i {
                        let current = prefix[i + 1] - prefix[m + 1] - nums[i] * (i - m) as i32;
                        if dp[j - 1][m] != i32::MAX {
                            dp[j][i] = dp[j][i].min(dp[j - 1][m] + current);
                        }
                    }
                }
            }
        }

        dp[k][n - 1]
    }
}
}