impl Solution {
    pub fn min_operations(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut dp = vec![0; n];

        for i in 0..m {
            let mut new_dp = dp.clone();
            for j in 0..n {
                let mut min_op = i32::MAX;
                for k in 0..j + 1 {
                    if grid[i][j] > grid[i][k] {
                        min_op = min_op.min(new_dp[k]);
                    }
                }
                new_dp[j] = min_op + (j as i32);
            }
            dp = new_dp;
        }

        dp.iter().cloned().min().unwrap()
    }
}