impl Solution {
    pub fn find_paths(m: i32, n: i32, max_move: i32, start_row: i32, start_column: i32) -> i32 {
        let mod_val = 1_000_000_007;
        let mut dp = vec![vec![vec![0; n as usize]; m as usize]; max_move as usize + 1];

        for move_count in 1..=max_move {
            for r in 0..m {
                for c in 0..n {
                    if r == 0 {
                        dp[move_count as usize][r as usize][c as usize] = (dp[move_count as usize][r as usize][c as usize] + 1) % mod_val;
                    }
                    if r == m - 1 {
                        dp[move_count as usize][r as usize][c as usize] = (dp[move_count as usize][r as usize][c as usize] + 1) % mod_val;
                    }
                    if c == 0 {
                        dp[move_count as usize][r as usize][c as usize] = (dp[move_count as usize][r as usize][c as usize] + 1) % mod_val;
                    }
                    if c == n - 1 {
                        dp[move_count as usize][r as usize][c as usize] = (dp[move_count as usize][r as usize][c as usize] + 1) % mod_val;
                    }
                    if r > 0 {
                        dp[move_count as usize][r as usize][c as usize] = (dp[move_count as usize][r as usize][c as usize] + dp[(move_count - 1) as usize][r as usize - 1][c as usize]) % mod_val;
                    }
                    if r < m - 1 {
                        dp[move_count as usize][r as usize][c as usize] = (dp[move_count as usize][r as usize][c as usize] + dp[(move_count - 1) as usize][r as usize + 1][c as usize]) % mod_val;
                    }
                    if c > 0 {
                        dp[move_count as usize][r as usize][c as usize] = (dp[move_count as usize][r as usize][c as usize] + dp[(move_count - 1) as usize][r as usize][c as usize - 1]) % mod_val;
                    }
                    if c < n - 1 {
                        dp[move_count as usize][r as usize][c as usize] = (dp[move_count as usize][r as usize][c as usize] + dp[(move_count - 1) as usize][r as usize][c as usize + 1]) % mod_val;
                    }
                }
            }
        }

        let mut result = 0;
        for move_count in 1..=max_move {
            result = (result + dp[move_count as usize][start_row as usize][start_column as usize]) % mod_val;
        }
        result
    }
}