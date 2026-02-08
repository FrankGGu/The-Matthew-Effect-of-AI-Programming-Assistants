impl Solution {
    pub fn shortest_common_supersequence(str1: String, str2: String) -> String {
        let s1_chars: Vec<char> = str1.chars().collect();
        let s2_chars: Vec<char> = str2.chars().collect();

        let n = s1_chars.len();
        let m = s2_chars.len();

        // dp[i][j] stores the length of the Longest Common Subsequence (LCS)
        // of s1_chars[0...i-1] and s2_chars[0...j-1].
        let mut dp = vec![vec![0; m + 1]; n + 1];

        // Fill dp table for LCS lengths
        for i in 1..=n {
            for j in 1..=m {
                if s1_chars[i - 1] == s2_chars[j - 1] {
                    dp[i][j] = 1 + dp[i - 1][j - 1];
                } else {
                    dp[i][j] = dp[i - 1][j].max(dp[i][j - 1]);
                }
            }
        }

        let mut res_chars = Vec::new();
        let mut i = n;
        let mut j = m;

        // Backtrack through the dp table to construct the SCS
        while i > 0 && j > 0 {
            if s1_chars[i - 1] == s2_chars[j - 1] {
                // If characters match, they are part of the LCS.
                // Add this character once to the SCS and move diagonally up.
                res_chars.push(s1_chars[i - 1]);
                i -= 1;
                j -= 1;
            } else if dp[i - 1][j] > dp[i][j - 1] {
                // If characters don't match, and the LCS length is greater
                // when we exclude s1_chars[i-1], it means s1_chars[i-1]
                // is not part of the LCS (from this path). Add it to SCS
                // and move up in s1 (decrement i).
                res_chars.push(s1_chars[i - 1]);
                i -= 1;
            } else { // dp[i][j-1] >= dp[i-1][j]
                // If characters don't match, and the LCS length is greater or equal
                // when we exclude s2_chars[j-1], it means s2_chars[j-1]
                // is not part of the LCS (from this path). Add it to SCS
                // and move left in s2 (decrement j).
                res_chars.push(s2_chars[j - 1]);
                j -= 1;
            }
        }

        // Add any remaining characters from str1 (if str2 was exhausted first)
        while i > 0 {
            res_chars.push(s1_chars[i - 1]);
            i -= 1;
        }

        // Add any remaining characters from str2 (if str1 was exhausted first)
        while j > 0 {
            res_chars.push(s2_chars[j - 1]);
            j -= 1;
        }

        // The result was built in reverse order, so reverse it
        res_chars.reverse();

        res_chars.into_iter().collect()
    }
}