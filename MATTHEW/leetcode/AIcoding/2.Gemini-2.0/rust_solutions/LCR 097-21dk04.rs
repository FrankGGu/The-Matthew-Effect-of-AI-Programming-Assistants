impl Solution {
    pub fn num_distinct(s: String, t: String) -> i32 {
        let s_chars: Vec<char> = s.chars().collect();
        let t_chars: Vec<char> = t.chars().collect();
        let s_len = s_chars.len();
        let t_len = t_chars.len();

        let mut dp: Vec<Vec<i64>> = vec![vec![0; s_len + 1]; t_len + 1];

        for j in 0..=s_len {
            dp[0][j] = 1;
        }

        for i in 1..=t_len {
            for j in 1..=s_len {
                if t_chars[i - 1] == s_chars[j - 1] {
                    dp[i][j] = dp[i - 1][j - 1] + dp[i][j - 1];
                } else {
                    dp[i][j] = dp[i][j - 1];
                }
            }
        }

        dp[t_len][s_len] as i32
    }
}