impl Solution {
    pub fn max_difference_score(grid: Vec<Vec<i32>>) -> i64 {
        let m = grid.len();
        let n = grid[0].len();
        let mut dp = vec![vec![i64::MIN; n]; m];
        dp[0][0] = grid[0][0] as i64;

        for i in 0..m {
            for j in 0..n {
                if i > 0 {
                    dp[i][j] = dp[i][j].max(dp[i - 1][j] + grid[i][j] as i64);
                }
                if j > 0 {
                    dp[i][j] = dp[i][j].max(dp[i][j - 1] + grid[i][j] as i64);
                }
            }
        }

        let mut dp2 = vec![vec![i64::MIN; n]; m];
        dp2[m - 1][n - 1] = grid[m - 1][n - 1] as i64;

        for i in (0..m).rev() {
            for j in (0..n).rev() {
                if i < m - 1 {
                    dp2[i][j] = dp2[i][j].max(dp2[i + 1][j] + grid[i][j] as i64);
                }
                if j < n - 1 {
                    dp2[i][j] = dp2[i][j].max(dp2[i][j + 1] + grid[i][j] as i64);
                }
            }
        }

        let mut ans = i64::MIN;
        for i in 0..m {
            for j in 0..n {
                if i > 0 && i < m - 1 {
                    ans = ans.max(dp[i - 1][j] + dp2[i + 1][j]);
                }
                if j > 0 && j < n - 1 {
                    ans = ans.max(dp[i][j - 1] + dp2[i][j + 1]);
                }
            }
        }

        ans
    }
}