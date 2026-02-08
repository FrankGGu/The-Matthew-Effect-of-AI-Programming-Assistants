impl Solution {
    pub fn max_product_path(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut dp = vec![vec![(0i64, 0i64); n]; m];
        dp[0][0] = (grid[0][0] as i64, grid[0][0] as i64);

        for i in 1..m {
            let val = dp[i-1][0].0 * grid[i][0] as i64;
            dp[i][0] = (val, val);
        }

        for j in 1..n {
            let val = dp[0][j-1].0 * grid[0][j] as i64;
            dp[0][j] = (val, val);
        }

        for i in 1..m {
            for j in 1..n {
                let val = grid[i][j] as i64;
                let max_top = dp[i-1][j].0 * val;
                let min_top = dp[i-1][j].1 * val;
                let max_left = dp[i][j-1].0 * val;
                let min_left = dp[i][j-1].1 * val;

                let max_val = max_top.max(min_top).max(max_left).max(min_left);
                let min_val = max_top.min(min_top).min(max_left).min(min_left);

                dp[i][j] = (max_val, min_val);
            }
        }

        let result = dp[m-1][n-1].0;
        if result < 0 {
            -1
        } else {
            (result % 1_000_000_007) as i32
        }
    }
}