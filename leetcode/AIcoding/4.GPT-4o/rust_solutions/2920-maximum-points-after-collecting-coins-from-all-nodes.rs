use std::collections::HashMap;

impl Solution {
    pub fn collect_maximum_coins(grid: Vec<Vec<i32>>) -> i32 {
        let rows = grid.len();
        let cols = grid[0].len();
        let mut dp = vec![vec![0; cols]; rows];

        dp[0][0] = grid[0][0];

        for i in 0..rows {
            for j in 0..cols {
                if i > 0 {
                    dp[i][j] = dp[i][j].max(dp[i-1][j] + grid[i][j]);
                }
                if j > 0 {
                    dp[i][j] = dp[i][j].max(dp[i][j-1] + grid[i][j]);
                }
            }
        }

        dp[rows-1][cols-1]
    }
}