impl Solution {
    pub fn minimum_sum(n: i32, k: i32) -> i32 {
        let mut dp = vec![i32::MAX; (n + 1) as usize];
        dp[0] = 0;

        for i in 1..=n {
            for j in 1..=i {
                if j != k {
                    dp[i as usize] = dp[i as usize].min(dp[(i - j) as usize] + j);
                }
            }
        }

        dp[n as usize]
    }
}