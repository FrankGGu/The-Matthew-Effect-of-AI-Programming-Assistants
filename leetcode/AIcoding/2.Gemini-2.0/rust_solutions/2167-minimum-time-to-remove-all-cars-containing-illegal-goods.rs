impl Solution {
    pub fn minimum_time(s: String) -> i32 {
        let n = s.len();
        let s: Vec<char> = s.chars().collect();
        let mut dp = vec![0; n + 1];

        for i in 1..=n {
            if s[i - 1] == '0' {
                dp[i] = dp[i - 1];
            } else {
                dp[i] = std::cmp::min(dp[i - 1] + 2, i as i32);
            }
        }

        let mut ans = dp[n];
        let mut suffix = 0;

        for i in (0..n).rev() {
            if s[i] == '1' {
                suffix = std::cmp::min(suffix + 2, (n - i) as i32);
            }
            ans = std::cmp::min(ans, dp[i] + suffix);
        }

        ans
    }
}