impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn matrix_block_sum(mat: Vec<Vec<i32>>, k: i32) -> Vec<Vec<i32>> {
        let m = mat.len();
        let n = mat[0].len();
        let mut dp = vec![vec![0; n]; m];

        for i in 0..m {
            for j in 0..n {
                dp[i][j] = mat[i][j];
                if i > 0 {
                    dp[i][j] += dp[i - 1][j];
                }
                if j > 0 {
                    dp[i][j] += dp[i][j - 1];
                }
                if i > 0 && j > 0 {
                    dp[i][j] -= dp[i - 1][j - 1];
                }
            }
        }

        let mut result = vec![vec![0; n]; m];

        for i in 0..m {
            for j in 0..n {
                let r1 = i as i32 - k;
                let c1 = j as i32 - k;
                let r2 = i as i32 + k;
                let c2 = j as i32 + k;

                let r1 = r1.max(0) as usize;
                let c1 = c1.max(0) as usize;
                let r2 = r2.min((m - 1) as i32) as usize;
                let c2 = c2.min((n - 1) as i32) as usize;

                result[i][j] = dp[r2][c2];
                if r1 > 0 {
                    result[i][j] -= dp[r1 - 1][c2];
                }
                if c1 > 0 {
                    result[i][j] -= dp[r2][c1 - 1];
                }
                if r1 > 0 && c1 > 0 {
                    result[i][j] += dp[r1 - 1][c1 - 1];
                }
            }
        }

        result
    }
}
}