impl Solution {
    pub fn count_sequences(n: i32, k: i32) -> i32 {
        const MOD: i32 = 1_000_000_007;
        let mut dp = vec![0; (n + 1) as usize];
        dp[0] = 1;

        for i in 1..=n {
            for j in 1..=k {
                if i - j >= 0 {
                    dp[i as usize] = (dp[i as usize] + dp[(i - j) as usize]) % MOD;
                }
            }
        }

        dp[n as usize]
    }
}