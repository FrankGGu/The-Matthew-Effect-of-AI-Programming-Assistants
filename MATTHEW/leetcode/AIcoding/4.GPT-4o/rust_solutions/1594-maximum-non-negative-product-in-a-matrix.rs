impl Solution {
    pub fn max_product_path(grid: Vec<Vec<i32>>) -> i32 {
        let mod_val = 1_000_000_007;
        let m = grid.len();
        let n = grid[0].len();
        let mut dp = vec![vec![(0, 0); n]; m];

        dp[0][0] = (grid[0][0], grid[0][0]);

        for i in 0..m {
            for j in 0..n {
                if i > 0 {
                    let (max_prev, min_prev) = dp[i - 1][j];
                    let max_curr = max_prev * grid[i][j];
                    let min_curr = min_prev * grid[i][j];
                    dp[i][j].0 = dp[i][j].0.max(max_curr).max(min_curr);
                    dp[i][j].1 = dp[i][j].1.min(max_curr).min(min_curr);
                }
                if j > 0 {
                    let (max_prev, min_prev) = dp[i][j - 1];
                    let max_curr = max_prev * grid[i][j];
                    let min_curr = min_prev * grid[i][j];
                    dp[i][j].0 = dp[i][j].0.max(max_curr).max(min_curr);
                    dp[i][j].1 = dp[i][j].1.min(max_curr).min(min_curr);
                }
            }
        }

        let result = dp[m - 1][n - 1].0;
        if result < 0 { return -1; }
        (result % mod_val) as i32
    }
}