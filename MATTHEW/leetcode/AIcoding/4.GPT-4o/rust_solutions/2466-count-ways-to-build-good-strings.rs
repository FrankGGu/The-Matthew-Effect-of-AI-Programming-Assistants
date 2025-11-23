impl Solution {
    pub fn count_good_strings(low: i32, high: i32, zero: i32, one: i32) -> i32 {
        const MOD: i32 = 1_000_000_007;
        let n = high + 1;
        let mut dp = vec![0; n as usize];
        dp[0] = 1;

        for i in 1..n as usize {
            if i >= zero as usize {
                dp[i] = (dp[i] + dp[i - zero as usize]) % MOD;
            }
            if i >= one as usize {
                dp[i] = (dp[i] + dp[i - one as usize]) % MOD;
            }
        }

        let mut result = 0;
        for i in low as usize..n as usize {
            result = (result + dp[i]) % MOD;
        }

        result
    }
}