impl Solution {
    pub fn count_good_strings(low: i32, high: i32, zero: i32, one: i32) -> i32 {
        let low = low as usize;
        let high = high as usize;
        let zero = zero as usize;
        let one = one as usize;

        let modulo = 1_000_000_007;

        let mut dp = vec![0; high + 1];
        dp[0] = 1;

        for i in 1..=high {
            if i >= zero {
                dp[i] = (dp[i] + dp[i - zero]) % modulo;
            }
            if i >= one {
                dp[i] = (dp[i] + dp[i - one]) % modulo;
            }
        }

        let mut total_good_strings = 0;
        for i in low..=high {
            total_good_strings = (total_good_strings + dp[i]) % modulo;
        }

        total_good_strings
    }
}