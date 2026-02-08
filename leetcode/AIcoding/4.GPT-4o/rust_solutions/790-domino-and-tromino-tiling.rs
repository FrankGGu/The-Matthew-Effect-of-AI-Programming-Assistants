impl Solution {
    pub fn num_tilings(n: i32) -> i32 {
        const MOD: i32 = 1_000_000_007;
        if n == 0 { return 1; }
        if n == 1 { return 1; }
        let mut dp = vec![0; (n + 1) as usize];
        dp[0] = 1;
        dp[1] = 1;
        let mut dp2 = vec![0; (n + 1) as usize];
        dp2[1] = 1;

        for i in 2..=n {
            dp[i as usize] = (dp[i as usize - 1] + dp[i as usize - 2] + 2 * dp2[i as usize - 1]) % MOD;
            dp2[i as usize] = (dp[i as usize - 1] + dp2[i as usize - 1]) % MOD;
        }
        dp[n as usize]
    }
}