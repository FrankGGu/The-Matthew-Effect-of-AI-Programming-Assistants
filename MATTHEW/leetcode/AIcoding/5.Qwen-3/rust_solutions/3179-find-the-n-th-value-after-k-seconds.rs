struct Solution;

impl Solution {
    pub fn value_after_k_seconds(k: i32, n: i32) -> i32 {
        let mut dp = vec![0; n as usize];
        for _ in 0..k {
            for i in 1..n as usize {
                dp[i] += dp[i - 1];
            }
        }
        dp[n as usize - 1]
    }
}