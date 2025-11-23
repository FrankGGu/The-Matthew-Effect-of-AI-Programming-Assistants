impl Solution {
    pub fn knight_dialer(n: i32) -> i32 {
        let mut dp = vec![1; 10];
        let modulo = 1_000_000_007;

        for _ in 1..n {
            let mut next_dp = vec![0; 10];
            next_dp[0] = (dp[4] + dp[6]) % modulo;
            next_dp[1] = (dp[6] + dp[8]) % modulo;
            next_dp[2] = (dp[7] + dp[9]) % modulo;
            next_dp[3] = (dp[4] + dp[8]) % modulo;
            next_dp[4] = (dp[0] + dp[3] + dp[9]) % modulo;
            next_dp[6] = (dp[0] + dp[1] + dp[7]) % modulo;
            next_dp[7] = (dp[2] + dp[6]) % modulo;
            next_dp[8] = (dp[1] + dp[3]) % modulo;
            next_dp[9] = (dp[2] + dp[4]) % modulo;

            dp = next_dp;
        }

        let mut sum = 0;
        for &count in &dp {
            sum = (sum + count) % modulo;
        }

        sum
    }
}