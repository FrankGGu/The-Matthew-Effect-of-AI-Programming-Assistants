impl Solution {
    pub fn count_good_strings(low: i32, high: i32, zero: i32, one: i32) -> i32 {
        let mod_num = 1_000_000_007;
        let high = high as usize;
        let zero = zero as usize;
        let one = one as usize;
        let mut dp = vec![0; high + 1];
        dp[0] = 1;

        for i in 1..=high {
            if i >= zero {
                dp[i] = (dp[i] + dp[i - zero]) % mod_num;
            }
            if i >= one {
                dp[i] = (dp[i] + dp[i - one]) % mod_num;
            }
        }

        let mut res = 0;
        for i in (low as usize)..=high {
            res = (res + dp[i]) % mod_num;
        }
        res
    }
}