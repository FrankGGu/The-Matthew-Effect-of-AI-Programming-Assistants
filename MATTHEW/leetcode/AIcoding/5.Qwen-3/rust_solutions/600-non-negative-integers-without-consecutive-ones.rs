struct Solution;

impl Solution {
    pub fn non_negative_integers(n: i32) -> i32 {
        let mut dp = vec![0; n as usize + 1];
        dp[0] = 1;
        if n == 0 {
            return 1;
        }
        dp[1] = 2;
        for i in 2..=n as usize {
            dp[i] = dp[i - 1] + dp[i - 2];
        }
        dp[n as usize]
    }
}