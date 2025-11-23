impl Solution {
    pub fn number_of_paths(grid: Vec<Vec<i32>>, k: i32) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let k = k as usize;
        let mod_val = 1_000_000_007;
        let mut dp = vec![vec![vec![0; k]; n]; m];

        dp[0][0][(grid[0][0] % k as i32) as usize] = 1;

        for i in 0..m {
            for j in 0..n {
                if i == 0 && j == 0 {
                    continue;
                }
                let current = grid[i][j] % k as i32;
                for prev_k in 0..k {
                    let new_k = (prev_k as i32 + current) % k as i32;
                    let new_k = new_k as usize;
                    if i > 0 {
                        dp[i][j][new_k] = (dp[i][j][new_k] + dp[i - 1][j][prev_k]) % mod_val;
                    }
                    if j > 0 {
                        dp[i][j][new_k] = (dp[i][j][new_k] + dp[i][j - 1][prev_k]) % mod_val;
                    }
                }
            }
        }

        dp[m - 1][n - 1][0]
    }
}