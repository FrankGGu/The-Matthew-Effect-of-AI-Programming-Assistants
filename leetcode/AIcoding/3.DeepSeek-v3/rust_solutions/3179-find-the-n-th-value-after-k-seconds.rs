impl Solution {
    pub fn value_after_k_seconds(n: i32, k: i32) -> i32 {
        let mut dp = vec![1; n as usize];
        let modulo = 1_000_000_007;
        for _ in 0..k {
            for i in 1..n as usize {
                dp[i] = (dp[i] + dp[i - 1]) % modulo;
            }
        }
        dp[n as usize - 1]
    }
}