impl Solution {
    pub fn count_ways(n: i32) -> i32 {
        const MOD: i32 = 1_000_000_007;
        let n = n as usize;
        let mut dp = vec![0; n + 1];
        dp[0] = 1;
        dp[1] = 2;

        for i in 2..=n {
            dp[i] = (dp[i - 1] + dp[i - 2] * 2) % MOD;
        }

        dp[n]
    }
}