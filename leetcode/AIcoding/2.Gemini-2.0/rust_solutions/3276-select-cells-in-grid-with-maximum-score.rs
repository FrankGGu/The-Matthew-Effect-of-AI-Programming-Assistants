impl Solution {
    pub fn max_points(grid: Vec<Vec<i32>>, k: i32) -> i64 {
        let m = grid.len();
        let n = grid[0].len();
        let mut dp = vec![vec![0i64; n]; m];
        dp[0][0] = grid[0][0] as i64;

        for i in 0..m {
            for j in 0..n {
                if i == 0 && j == 0 {
                    continue;
                }
                let mut max_val = 0i64;
                if i > 0 {
                    max_val = max_val.max(dp[i - 1][j] - k as i64);
                }
                if j > 0 {
                    max_val = max_val.max(dp[i][j - 1] - k as i64);
                }
                dp[i][j] = max_val + grid[i][j] as i64;
            }
        }

        dp[m - 1][n - 1]
    }
}