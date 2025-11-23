impl Solution {
    pub fn number_of_paths(grid: Vec<Vec<i32>>, k: i32) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let k_usize = k as usize;
        let modulo = 1_000_000_007;

        let mut dp = vec![vec![vec![0; k_usize]; n]; m];

        let initial_remainder = grid[0][0] as usize % k_usize;
        dp[0][0][initial_remainder] = 1;

        for i in 0..m {
            for j in 0..n {
                let current_grid_val = grid[i][j] as usize;

                if i == 0 && j == 0 {
                    continue;
                }

                for prev_rem in 0..k_usize {
                    let target_rem = (prev_rem + current_grid_val) % k_usize;

                    if i > 0 {
                        dp[i][j][target_rem] = (dp[i][j][target_rem] + dp[i-1][j][prev_rem]) % modulo;
                    }

                    if j > 0 {
                        dp[i][j][target_rem] = (dp[i][j][target_rem] + dp[i][j-1][prev_rem]) % modulo;
                    }
                }
            }
        }

        dp[m-1][n-1][0] as i32
    }
}