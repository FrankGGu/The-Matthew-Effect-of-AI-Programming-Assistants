impl Solution {
    pub fn min_insertions(s: String) -> i32 {
        let n = s.len();
        let s_bytes = s.as_bytes();
        let mut dp = vec![vec![0; n]; n];

        for len in 2..=n {
            for i in 0..=n - len {
                let j = i + len - 1;
                if s_bytes[i] == s_bytes[j] {
                    dp[i][j] = dp[i + 1][j - 1];
                } else {
                    dp[i][j] = std::cmp::min(dp[i + 1][j], dp[i][j - 1]) + 1;
                }
            }
        }

        dp[0][n - 1]
    }
}