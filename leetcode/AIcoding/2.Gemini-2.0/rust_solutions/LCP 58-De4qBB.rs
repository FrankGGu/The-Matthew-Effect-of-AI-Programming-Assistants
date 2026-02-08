impl Solution {
    pub fn num_tilings(n: i32) -> i32 {
        let n = n as usize;
        if n <= 2 {
            return n as i32;
        }
        let mut dp = vec![0; n + 1];
        let mut mod_val = 1000000007;
        dp[0] = 0;
        dp[1] = 1;
        dp[2] = 2;
        dp[3] = 5;

        for i in 4..=n {
            dp[i] = ((2 * dp[i - 1]) as i64 + (dp[i - 3]) as i64) as i32 % mod_val;
        }

        dp[n]
    }
}