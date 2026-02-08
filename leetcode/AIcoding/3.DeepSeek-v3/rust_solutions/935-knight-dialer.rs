const MOD: i64 = 1_000_000_007;

impl Solution {
    pub fn knight_dialer(n: i32) -> i32 {
        if n == 1 {
            return 10;
        }
        let mut dp = vec![1; 10];
        for _ in 1..n {
            let mut next = vec![0; 10];
            next[0] = (dp[4] + dp[6]) % MOD;
            next[1] = (dp[6] + dp[8]) % MOD;
            next[2] = (dp[7] + dp[9]) % MOD;
            next[3] = (dp[4] + dp[8]) % MOD;
            next[4] = (dp[0] + dp[3] + dp[9]) % MOD;
            next[5] = 0;
            next[6] = (dp[0] + dp[1] + dp[7]) % MOD;
            next[7] = (dp[2] + dp[6]) % MOD;
            next[8] = (dp[1] + dp[3]) % MOD;
            next[9] = (dp[2] + dp[4]) % MOD;
            dp = next;
        }
        (dp.iter().sum::<i64>() % MOD) as i32
    }
}