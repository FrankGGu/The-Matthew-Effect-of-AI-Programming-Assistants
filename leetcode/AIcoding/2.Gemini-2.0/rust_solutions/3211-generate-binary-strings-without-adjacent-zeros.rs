impl Solution {
    pub fn generate_strings_without_adjacent_zeros(n: i32) -> i32 {
        let n = n as usize;
        let mut dp = vec![(0, 0); n + 1];
        dp[1] = (1, 1);
        for i in 2..=n {
            dp[i].0 = (dp[i - 1].0 + dp[i - 1].1) % 1000000007;
            dp[i].1 = dp[i - 1].0;
        }
        ((dp[n].0 + dp[n].1) % 1000000007) as i32
    }
}