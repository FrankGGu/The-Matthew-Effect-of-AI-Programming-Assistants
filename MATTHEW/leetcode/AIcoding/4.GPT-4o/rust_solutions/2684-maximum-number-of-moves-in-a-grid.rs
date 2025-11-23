impl Solution {
    pub fn max_moves(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut dp = vec![vec![0; n]; m];

        for j in 0..n {
            dp[m - 1][j] = 1;
        }

        for i in (0..m - 1).rev() {
            for j in 0..n {
                for k in 0..n {
                    if grid[i][j] < grid[i + 1][k] {
                        dp[i][j] = dp[i][j].max(dp[i + 1][k] + 1);
                    }
                }
            }
        }

        dp[0].iter().cloned().max().unwrap_or(0)
    }
}