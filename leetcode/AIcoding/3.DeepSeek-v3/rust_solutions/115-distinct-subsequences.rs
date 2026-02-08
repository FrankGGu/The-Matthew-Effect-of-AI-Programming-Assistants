impl Solution {
    pub fn num_distinct(s: String, t: String) -> i32 {
        let s_chars: Vec<char> = s.chars().collect();
        let t_chars: Vec<char> = t.chars().collect();
        let m = s_chars.len();
        let n = t_chars.len();

        let mut dp = vec![vec![0; n + 1]; m + 1];

        for i in 0..=m {
            dp[i][0] = 1;
        }

        for i in 1..=m {
            for j in 1..=n {
                if s_chars[i - 1] == t_chars[j - 1] {
                    dp[i][j] = dp[i - 1][j - 1] + dp[i - 1][j];
                } else {
                    dp[i][j] = dp[i - 1][j];
                }
            }
        }

        dp[m][n]
    }
}