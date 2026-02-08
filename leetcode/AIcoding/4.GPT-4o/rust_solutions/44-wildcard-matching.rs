impl Solution {
    pub fn is_match(s: String, p: String) -> bool {
        let (s_len, p_len) = (s.len(), p.len());
        let mut dp = vec![vec![false; p_len + 1]; s_len + 1];
        dp[0][0] = true;

        for j in 1..=p_len {
            if p.chars().nth(j - 1) == Some('*') {
                dp[0][j] = dp[0][j - 1];
            }
        }

        for i in 1..=s_len {
            for j in 1..=p_len {
                if p.chars().nth(j - 1) == Some('*') {
                    dp[i][j] = dp[i][j - 1] || dp[i - 1][j];
                } else if p.chars().nth(j - 1) == Some('?') || p.chars().nth(j - 1) == Some(s.chars().nth(i - 1).unwrap()) {
                    dp[i][j] = dp[i - 1][j - 1];
                }
            }
        }

        dp[s_len][p_len]
    }
}