impl Solution {
    pub fn keyboard(k: i32, n: i32) -> i32 {
        const MOD: i64 = 1_000_000_007;
        let k = k as usize;
        let n = n as usize;
        let mut dp = vec![vec![0; n + 1]; k + 1];
        dp[0][0] = 1;
        for i in 0..=k {
            for j in 0..=n {
                if i == 0 && j == 0 {
                    continue;
                }
                if i > 0 {
                    dp[i][j] = (dp[i][j] + dp[i - 1][j]) % MOD;
                }
                if j > 0 && i > 0 {
                    dp[i][j] = (dp[i][j] + dp[i][j - 1] * i as i64) % MOD;
                }
            }
        }
        dp[k][n] as i32
    }
}