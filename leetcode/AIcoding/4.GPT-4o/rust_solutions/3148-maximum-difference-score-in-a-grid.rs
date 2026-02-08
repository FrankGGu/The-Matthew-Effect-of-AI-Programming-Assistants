impl Solution {
    pub fn max_difference_score(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut dp = vec![vec![0; n]; m];

        for i in 0..m {
            for j in 0..n {
                dp[i][j] = grid[i][j];
                if i > 0 {
                    dp[i][j] = dp[i][j].max(dp[i-1][j]);
                }
                if j > 0 {
                    dp[i][j] = dp[i][j].max(dp[i][j-1]);
                }
            }
        }

        let mut max_score = 0;
        for i in 0..m {
            for j in 0..n {
                max_score = max_score.max(dp[i][j] - grid[i][j]);
            }
        }

        max_score
    }
}