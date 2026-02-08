impl Solution {
    pub fn rearrange_sticks(n: i32, k: i32) -> i32 {
        const MOD: i32 = 1_000_000_007;
        let n = n as usize;
        let k = k as usize;
        let mut dp = vec![vec![0; k + 1]; n + 1];
        dp[0][0] = 1;

        for i in 1..=n {
            for j in 0..=k {
                dp[i][j] = dp[i - 1][j] * i as i32 % MOD;
                if j > 0 {
                    dp[i][j] = (dp[i][j] + dp[i - 1][j - 1]) % MOD;
                }
            }
        }

        dp[n][k]
    }
}