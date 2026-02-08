impl Solution {
    pub fn count_orders(n: i32) -> i32 {
        const MOD: i32 = 1_000_000_007;
        let mut dp = vec![0; (n + 1) as usize];
        dp[0] = 1;

        for i in 1..=n {
            dp[i as usize] = dp[(i - 1) as usize] * (2 * i * (2 * i - 1) % MOD) % MOD;
        }

        dp[n as usize]
    }
}