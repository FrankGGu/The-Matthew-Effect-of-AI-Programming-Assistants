impl Solution {
    pub fn num_tilings(n: i32) -> i32 {
        let n = n as usize;
        let modulo: i64 = 1_000_000_007;

        if n == 1 {
            return 1;
        }
        if n == 2 {
            return 2;
        }

        let mut dp = vec![0i64; n + 1];
        dp[0] = 1;
        dp[1] = 1;
        dp[2] = 2;

        for i in 3..=n {
            dp[i] = (2 * dp[i-1] + dp[i-3]) % modulo;
        }

        dp[n] as i32
    }
}