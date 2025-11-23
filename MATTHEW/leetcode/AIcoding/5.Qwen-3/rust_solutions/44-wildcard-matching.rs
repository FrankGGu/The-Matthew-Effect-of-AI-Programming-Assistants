impl Solution {
    pub fn is_match(s: String, p: String) -> bool {
        let s = s.as_bytes();
        let p = p.as_bytes();
        let mut dp = vec![vec![false; p.len() + 1]; s.len() + 1];
        dp[0][0] = true;

        for j in 1..=p.len() {
            if p[j - 1] == b'*' {
                dp[0][j] = dp[0][j - 1];
            }
        }

        for i in 1..=s.len() {
            for j in 1..=p.len() {
                if p[j - 1] == b'*' {
                    dp[i][j] = dp[i][j - 1] || dp[i - 1][j];
                } else {
                    dp[i][j] = dp[i - 1][j - 1] && (s[i - 1] == p[j - 1] || p[j - 1] == b'?');
                }
            }
        }

        dp[s.len()][p.len()]
    }
}