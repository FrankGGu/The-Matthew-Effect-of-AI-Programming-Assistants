impl Solution {
    pub fn num_tilings(n: i32) -> i32 {
        let n = n as usize;
        if n <= 2 {
            return n as i32;
        }
        let modulo = 1_000_000_007;
        let mut dp = vec![0; n + 1];
        dp[0] = 1;
        dp[1] = 1;
        dp[2] = 2;
        for i in 3..=n {
            dp[i] = (2 * dp[i - 1] % modulo + dp[i - 3] % modulo) % modulo;
        }
        dp[n] as i32
    }
}