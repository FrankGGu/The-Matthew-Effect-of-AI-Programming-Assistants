impl Solution {
    pub fn is_match(s: String, p: String) -> bool {
        let s_chars: Vec<char> = s.chars().collect();
        let p_raw_chars: Vec<char> = p.chars().collect();

        // Optimize pattern: remove consecutive '*'
        // E.g., "a**b" becomes "a*b"
        let mut p_chars = Vec::new();
        for &ch in p_raw_chars.iter() {
            if ch == '*' {
                if p_chars.is_empty() || *p_chars.last().unwrap() != '*' {
                    p_chars.push(ch);
                }
            } else {
                p_chars.push(ch);
            }
        }

        let m = s_chars.len();
        let n = p_chars.len();

        // dp[j] represents dp[current_i][j]
        // prev_dp[j] represents dp[current_i - 1][j]
        let mut dp = vec![false; n + 1];
        let mut prev_dp = vec![false; n + 1];

        // Base case: empty string matches empty pattern
        prev_dp[0] = true; // Corresponds to dp[0][0]

        // Fill first row: s is empty, p is not
        // Only '*' can match an empty string
        for j in 1..=n {
            if p_chars[j - 1] == '*' {
                prev_dp[j] = prev_dp[j - 1]; // dp[0][j] = dp[0][j-1]
            }
        }

        // Fill the rest of the DP table
        for i in 1..=m {
            // dp[0] (s is not empty, p is empty) is always false
            dp[0] = false;

            for j in 1..=n {
                if p_chars[j - 1] == '?' || s_chars[i - 1] == p_chars[j - 1] {
                    // Current characters match or pattern has '?',
                    // so match depends on the diagonal element from the previous row
                    dp[j] = prev_dp[j - 1]; // dp[i][j] = dp[i-1][j-1]
                } else if p_chars[j - 1] == '*' {
                    // '*' can match an empty sequence (dp[i][j-1])
                    // OR '*' can match one or more characters (dp[i-1][j])
                    dp[j] = dp[j - 1] || prev_dp[j];
                } else {
                    // Characters don't match and not '?' or '*'
                    dp[j] = false;
                }
            }
            // Move current dp row to prev_dp for the next iteration
            prev_dp.copy_from_slice(&dp);
        }

        // The final result is dp[m][n], which is stored in prev_dp[n] after the last iteration
        prev_dp[n]
    }
}