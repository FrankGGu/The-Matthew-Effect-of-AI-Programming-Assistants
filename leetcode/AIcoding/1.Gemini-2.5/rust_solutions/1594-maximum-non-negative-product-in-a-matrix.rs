impl Solution {
    pub fn max_product_path(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let modulo = 1_000_000_007;

        let mut dp_max: Vec<Vec<i64>> = vec![vec![0; n]; m];
        let mut dp_min: Vec<Vec<i64>> = vec![vec![0; n]; m];

        dp_max[0][0] = grid[0][0] as i64;
        dp_min[0][0] = grid[0][0] as i64;

        for c in 1..n {
            let val = grid[0][c] as i64;
            dp_max[0][c] = dp_max[0][c-1] * val;
            dp_min[0][c] = dp_min[0][c-1] * val;
        }

        for r in 1..m {
            let val = grid[r][0] as i64;
            dp_max[r][0] = dp_max[r-1][0] * val;
            dp_min[r][0] = dp_min[r-1][0] * val;
        }

        for r in 1..m {
            for c in 1..n {
                let val = grid[r][c] as i64;

                if val >= 0 {
                    dp_max[r][c] = std::cmp::max(dp_max[r-1][c], dp_max[r][c-1]) * val;
                    dp_min[r][c] = std::cmp::min(dp_min[r-1][c], dp_min[r][c-1]) * val;
                } else {
                    dp_max[r][c] = std::cmp::min(dp_min[r-1][c], dp_min[r][c-1]) * val;
                    dp_min[r][c] = std::cmp::max(dp_max[r-1][c], dp_max[r][c-1]) * val;
                }
            }
        }

        let result = dp_max[m-1][n-1];
        if result < 0 {
            -1
        } else {
            (result % modulo) as i32
        }
    }
}