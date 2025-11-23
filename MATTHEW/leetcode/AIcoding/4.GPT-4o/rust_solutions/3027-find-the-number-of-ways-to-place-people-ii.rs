impl Solution {
    pub fn count_ways(n: i32, k: i32) -> i32 {
        const MOD: i32 = 1_000_000_007;
        let n = n as usize;
        let k = k as usize;

        if n == 0 {
            return 1;
        }

        let mut dp = vec![0; n + 1];
        dp[0] = 1;
        dp[1] = k;

        for i in 2..=n {
            dp[i] = ((k - 1) * (dp[i - 1] + dp[i - 2])) % MOD;
        }

        dp[n]
    }
}