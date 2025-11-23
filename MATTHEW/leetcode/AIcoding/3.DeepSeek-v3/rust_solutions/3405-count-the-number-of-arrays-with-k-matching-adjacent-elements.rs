impl Solution {
    pub fn count_arrays(n: i32, m: i32, k: i32) -> i32 {
        const MOD: i32 = 1_000_000_007;
        let n = n as usize;
        let m = m as usize;
        let k = k as usize;

        if k >= n {
            return 0;
        }

        let mut dp = vec![vec![0; k + 1]; n + 1];
        dp[1][0] = m as i32;

        for i in 2..=n {
            for j in 0..=k.min(i - 1) {
                dp[i][j] = (dp[i - 1][j] as i64 * (m - 1) as i64 % MOD as i64) as i32;
                if j > 0 {
                    dp[i][j] = (dp[i][j] as i64 + dp[i - 1][j - 1] as i64) % MOD as i64 as i32;
                }
            }
        }

        dp[n][k]
    }
}