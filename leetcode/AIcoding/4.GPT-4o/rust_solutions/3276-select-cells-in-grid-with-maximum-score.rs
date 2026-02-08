impl Solution {
    pub fn max_score(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut dp = vec![vec![0; n + 1]; m + 1];

        for i in 1..=m {
            for j in 1..=n {
                dp[i][j] = dp[i - 1][j].max(dp[i][j - 1]) + grid[i - 1][j - 1];
            }
        }

        let mut max_score = 0;
        for i in 1..=m {
            for j in 1..=n {
                max_score = max_score.max(dp[i][j]);
            }
        }

        max_score
    }
}