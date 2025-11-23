impl Solution {
    pub fn count_ways(steps: i32, arr_len: i32) -> i32 {
        let mod_val = 1_000_000_007;
        let max_col = arr_len.min((steps + 1) / 2) as usize + 1;
        let mut dp = vec![vec![0; max_col]; 2];
        dp[0][0] = 1;

        for i in 1..=steps {
            for j in 0..max_col {
                dp[i % 2][j] = dp[(i - 1) % 2][j];
                if j > 0 {
                    dp[i % 2][j] = (dp[i % 2][j] + dp[(i - 1) % 2][j - 1]) % mod_val;
                }
                if j + 1 < max_col {
                    dp[i % 2][j] = (dp[i % 2][j] + dp[(i - 1) % 2][j + 1]) % mod_val;
                }
            }
        }

        dp[steps % 2][0]
    }
}