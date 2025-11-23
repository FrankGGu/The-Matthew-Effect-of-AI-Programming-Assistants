impl Solution {
    pub fn max_product_path(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();

        let mut max_dp = vec![vec![0.0; n]; m];
        let mut min_dp = vec![vec![0.0; n]; m];

        max_dp[0][0] = grid[0][0] as f64;
        min_dp[0][0] = grid[0][0] as f64;

        for i in 1..m {
            max_dp[i][0] = max_dp[i - 1][0] * (grid[i][0] as f64);
            min_dp[i][0] = min_dp[i - 1][0] * (grid[i][0] as f64);
        }

        for j in 1..n {
            max_dp[0][j] = max_dp[0][j - 1] * (grid[0][j] as f64);
            min_dp[0][j] = min_dp[0][j - 1] * (grid[0][j] as f64);
        }

        for i in 1..m {
            for j in 1..n {
                let a = max_dp[i - 1][j] * (grid[i][j] as f64);
                let b = min_dp[i - 1][j] * (grid[i][j] as f64);
                let c = max_dp[i][j - 1] * (grid[i][j] as f64);
                let d = min_dp[i][j - 1] * (grid[i][j] as f64);

                max_dp[i][j] = a.max(b).max(c).max(d);
                min_dp[i][j] = a.min(b).min(c).min(d);
            }
        }

        let result = max_dp[m - 1][n - 1];
        if result < 0.0 {
            -1
        } else {
            (result as i64 % 1000000007) as i32
        }
    }
}