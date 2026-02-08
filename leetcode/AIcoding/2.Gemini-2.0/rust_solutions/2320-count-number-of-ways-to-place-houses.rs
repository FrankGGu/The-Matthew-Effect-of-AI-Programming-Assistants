impl Solution {
    pub fn count_house_placements(n: i32) -> i32 {
        let n = n as usize;
        let mut dp = vec![0; n + 1];
        dp[0] = 1;
        dp[1] = 2;

        for i in 2..=n {
            dp[i] = (dp[i - 1] + dp[i - 2]) % 1000000007;
        }

        ((dp[n] as i64) * (dp[n] as i64) % 1000000007) as i32
    }
}