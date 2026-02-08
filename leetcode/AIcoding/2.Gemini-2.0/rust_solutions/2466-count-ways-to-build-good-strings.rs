impl Solution {
    pub fn count_good_strings(low: i32, high: i32, zero: i32, one: i32) -> i32 {
        let modulo: i64 = 1_000_000_007;
        let mut dp = vec![0i64; high as usize + 1];
        dp[0] = 1;
        let mut ans = 0;

        for i in 1..=high as usize {
            if i >= zero as usize {
                dp[i] = (dp[i] + dp[i - zero as usize]) % modulo;
            }
            if i >= one as usize {
                dp[i] = (dp[i] + dp[i - one as usize]) % modulo;
            }

            if i >= low as usize {
                ans = (ans + dp[i]) % modulo;
            }
        }

        ans as i32
    }
}