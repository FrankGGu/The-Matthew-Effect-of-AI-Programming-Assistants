use std::cmp::max;

impl Solution {
    pub fn max_number_of_whacks(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut dp = vec![vec![0; n]; m];
        let mut ans = 0;

        for i in 0..m {
            for j in 0..n {
                dp[i][j] = grid[i][j];
                if i > 0 {
                    dp[i][j] = max(dp[i][j], dp[i - 1][j] + grid[i][j]);
                }
                if j > 0 {
                    dp[i][j] = max(dp[i][j], dp[i][j - 1] + grid[i][j]);
                }
                if i > 0 && j > 0 {
                    dp[i][j] = max(dp[i][j], dp[i - 1][j - 1] + grid[i][j]);
                }
                if i > 0 && j < n - 1 {
                    dp[i][j] = max(dp[i][j], dp[i - 1][j + 1] + grid[i][j]);
                }
                ans = max(ans, dp[i][j]);
            }
        }

        ans
    }
}