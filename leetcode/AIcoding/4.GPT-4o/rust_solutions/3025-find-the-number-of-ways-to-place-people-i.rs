impl Solution {
    pub fn count_ways(n: i32) -> i32 {
        const MOD: i32 = 1_000_000_007;
        let mut dp = vec![0; (n + 1) as usize];
        dp[0] = 1;
        dp[1] = 1;

        for i in 2..=n {
            dp[i as usize] = (dp[(i - 1) as usize] + (i - 1) * dp[(i - 2) as usize]) % MOD;
        }

        dp[n as usize]
    }
}