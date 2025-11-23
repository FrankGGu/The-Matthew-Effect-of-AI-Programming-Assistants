impl Solution {
    pub fn num_distinct(s: String, t: String) -> i32 {
        let s_chars: Vec<char> = s.chars().collect();
        let t_chars: Vec<char> = t.chars().collect();

        let s_len = s_chars.len();
        let t_len = t_chars.len();

        let mut dp = vec![vec![0_i64; t_len + 1]; s_len + 1];

        for i in 0..=s_len {
            dp[i][0] = 1;
        }

        for i in 1..=s_len {
            for j in 1..=t_len {
                if s_chars[i - 1] == t_chars[j - 1] {
                    dp[i][j] = dp[i - 1][j - 1] + dp[i - 1][j];
                } else {
                    dp[i][j] = dp[i - 1][j];
                }
            }
        }

        dp[s_len][t_len] as i32
    }
}