impl Solution {

use std::cmp::min;

struct Solution;

impl Solution {
    pub fn min_space_wasted_for_packaging(quantities: Vec<i32>, weights: Vec<i32>) -> i32 {
        let n = quantities.len();
        let m = weights.len();
        let mut dp = vec![vec![0; m]; n];

        for i in 0..n {
            for j in 0..m {
                if i == 0 {
                    dp[i][j] = (weights[j] - quantities[i]).abs();
                } else {
                    dp[i][j] = i32::MAX;
                    for k in 0..=j {
                        if dp[i - 1][k] != i32::MAX {
                            dp[i][j] = min(dp[i][j], dp[i - 1][k] + (weights[j] - quantities[i]).abs());
                        }
                    }
                }
            }
        }

        *dp[n - 1].iter().min().unwrap()
    }
}
}