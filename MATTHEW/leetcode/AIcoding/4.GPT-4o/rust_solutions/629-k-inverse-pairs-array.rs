impl Solution {
    pub fn k_inverse_pairs(n: i32, k: i32) -> i32 {
        const MOD: i32 = 1_000_000_007;
        let n = n as usize;
        let k = k as usize;
        let mut dp = vec![vec![0; k + 1]; n + 1];
        dp[0][0] = 1;

        for i in 1..=n {
            for j in 0..=k {
                dp[i][j] = dp[i - 1][j] % MOD;
                if j > 0 {
                    dp[i][j] = (dp[i][j] + dp[i][j - 1]) % MOD;
                }
                if j >= i {
                    dp[i][j] = (dp[i][j] - dp[i - 1][j - i] + MOD) % MOD;
                }
            }
        }

        dp[n][k]
    }
}