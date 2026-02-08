impl Solution {
    pub fn grid_teleportation_traversal(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut dp = vec![vec![0; n]; m];
        dp[0][0] = grid[0][0];

        for i in 0..m {
            for j in 0..n {
                if i > 0 {
                    dp[i][j] = dp[i][j].max(dp[i - 1][j] + grid[i][j]);
                }
                if j > 0 {
                    dp[i][j] = dp[i][j].max(dp[i][j - 1] + grid[i][j]);
                }
            }
        }
        dp[m - 1][n - 1]
    }
}