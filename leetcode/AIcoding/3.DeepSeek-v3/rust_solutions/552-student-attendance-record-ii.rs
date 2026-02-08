impl Solution {
    pub fn check_record(n: i32) -> i32 {
        const MOD: i64 = 1_000_000_007;
        let n = n as usize;
        if n == 0 {
            return 0;
        }
        let mut dp = vec![vec![vec![0; 3]; 2]; n + 1];
        dp[0][0][0] = 1;
        for i in 1..=n {
            for a in 0..2 {
                for l in 0..3 {
                    // Add 'P'
                    dp[i][a][0] = (dp[i][a][0] + dp[i - 1][a][l]) % MOD;
                    // Add 'A'
                    if a < 1 {
                        dp[i][a + 1][0] = (dp[i][a + 1][0] + dp[i - 1][a][l]) % MOD;
                    }
                    // Add 'L'
                    if l < 2 {
                        dp[i][a][l + 1] = (dp[i][a][l + 1] + dp[i - 1][a][l]) % MOD;
                    }
                }
            }
        }
        let mut res = 0;
        for a in 0..2 {
            for l in 0..3 {
                res = (res + dp[n][a][l]) % MOD;
            }
        }
        res as i32
    }
}