impl Solution {

use std::cmp::{max, min};

impl Solution {
    pub fn max_non_negative_product(mat: Vec<Vec<i32>>) -> i32 {
        let m = mat.len();
        let n = mat[0].len();
        let mut max_dp = vec![vec![0; n]; m];
        let mut min_dp = vec![vec![0; n]; m];

        max_dp[0][0] = mat[0][0];
        min_dp[0][0] = mat[0][0];

        for j in 1..n {
            max_dp[0][j] = max_dp[0][j - 1] * mat[0][j];
            min_dp[0][j] = min_dp[0][j - 1] * mat[0][j];
        }

        for i in 1..m {
            max_dp[i][0] = max_dp[i - 1][0] * mat[i][0];
            min_dp[i][0] = min_dp[i - 1][0] * mat[i][0];
        }

        for i in 1..m {
            for j in 1..n {
                let val = mat[i][j];
                let max_val = max(max_dp[i - 1][j], max_dp[i][j - 1]);
                let min_val = min(min_dp[i - 1][j], min_dp[i][j - 1]);
                max_dp[i][j] = max_val * val;
                min_dp[i][j] = min_val * val;
            }
        }

        max(max_dp[m - 1][n - 1], 0)
    }
}
}