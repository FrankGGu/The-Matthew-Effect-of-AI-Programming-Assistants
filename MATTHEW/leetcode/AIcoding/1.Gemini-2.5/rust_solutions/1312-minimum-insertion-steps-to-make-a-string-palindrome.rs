impl Solution {
    pub fn min_insertions(s: String) -> i32 {
        let n = s.len();
        if n <= 1 {
            return 0;
        }

        let s_chars: Vec<char> = s.chars().collect();
        let mut rev_s_chars: Vec<char> = s_chars.clone();
        rev_s_chars.reverse();

        // dp[i][j] stores the length of the Longest Common Subsequence (LCS)
        // of s_chars[0...i-1] and rev_s_chars[0...j-1]
        let mut dp = vec![vec![0; n + 1]; n + 1];

        for i in 1..=n {
            for j in 1..=n {
                if s_chars[i - 1] == rev_s_chars[j - 1] {
                    dp[i][j] = 1 + dp[i - 1][j - 1];
                } else {
                    dp[i][j] = dp[i - 1][j].max(dp[i][j - 1]);
                }
            }
        }

        // The length of the Longest Palindromic Subsequence (LPS) is LCS(s, reverse(s)).
        // The minimum number of insertions to make a string a palindrome
        // is (string length) - (length of LPS).
        n as i32 - dp[n][n]
    }
}