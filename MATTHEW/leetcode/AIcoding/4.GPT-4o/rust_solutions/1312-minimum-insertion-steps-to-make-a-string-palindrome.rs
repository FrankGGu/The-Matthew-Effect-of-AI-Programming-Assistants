impl Solution {
    pub fn min_insertions(s: String) -> i32 {
        let n = s.len();
        let s: Vec<char> = s.chars().collect();
        let mut dp = vec![vec![0; n]; n];

        for len in 2..=n {
            for i in 0..=n - len {
                let j = i + len - 1;
                if s[i] == s[j] {
                    dp[i][j] = dp[i + 1][j - 1];
                } else {
                    dp[i][j] = 1 + dp[i + 1][j].min(dp[i][j - 1]);
                }
            }
        }

        dp[0][n - 1]
    }
}