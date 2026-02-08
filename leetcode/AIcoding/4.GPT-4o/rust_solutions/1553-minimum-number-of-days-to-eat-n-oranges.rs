impl Solution {
    pub fn min_days(n: i32) -> i32 {
        if n == 0 {
            return 0;
        }
        let mut dp = vec![0; (n + 1) as usize];
        dp[0] = 0;
        for i in 1..=n {
            dp[i as usize] = 1 + dp[(i - 1) as usize];
            if i % 2 == 0 {
                dp[i as usize] = dp[i as usize].min(1 + dp[(i / 2) as usize]);
            }
            if i % 3 == 0 {
                dp[i as usize] = dp[i as usize].min(1 + dp[(i / 3) as usize]);
            }
        }
        dp[n as usize]
    }
}