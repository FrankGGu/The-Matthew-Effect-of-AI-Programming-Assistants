impl Solution {
    pub fn num_tilings(n: i32) -> i32 {
        let n = n as usize;
        if n == 1 {
            return 1;
        }
        if n == 2 {
            return 2;
        }
        if n == 3 {
            return 5;
        }
        let modulo = 1_000_000_007;
        let mut dp = vec![0; n + 1];
        dp[0] = 1;
        dp[1] = 1;
        dp[2] = 2;
        dp[3] = 5;
        for i in 4..=n {
            dp[i] = (2 * dp[i - 1] % modulo + dp[i - 3] % modulo) % modulo;
        }
        dp[n]
    }
}