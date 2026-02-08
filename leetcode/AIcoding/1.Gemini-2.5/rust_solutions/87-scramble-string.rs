impl Solution {
    pub fn is_scramble(s1: String, s2: String) -> bool {
        let n = s1.len();
        if n != s2.len() {
            return false;
        }
        if n == 0 {
            return true;
        }
        if s1 == s2 {
            return true;
        }

        let s1_chars: Vec<char> = s1.chars().collect();
        let s2_chars: Vec<char> = s2.chars().collect();

        // dp[i][j][len] will be true if s1[i...i+len-1] is a scramble of s2[j...j+len-1]
        // i: starting index in s1
        // j: starting index in s2
        // len: length of the substring
        let mut dp = vec![vec![vec![false; n + 1]; n]; n];

        // Base case: substrings of length 1
        for i in 0..n {
            for j in 0..n {
                dp[i][j][1] = s1_chars[i] == s2_chars[j];
            }
        }

        // Iterate over length of substrings
        for len in 2..=n {
            // Iterate over starting index for s1
            for i in 0..=n - len {
                // Iterate over starting index for s2
                for j in 0..=n - len {
                    // Iterate over all possible split points k
                    // k is the length of the first part, 1 <= k < len
                    for k in 1..len {
                        // Case 1: No swap
                        // s1[i...i+k-1] is a scramble of s2[j...j+k-1]
                        // AND s1[i+k...i+len-1] is a scramble of s2[j+k...j+len-1]
                        if dp[i][j][k] && dp[i + k][j + k][len - k] {
                            dp[i][j][len] = true;
                            break; // Found a way, no need to check other k values
                        }

                        // Case 2: Swap
                        // s1[i...i+k-1] is a scramble of s2[j+len-k...j+len-1]
                        // AND s1[i+k...i+len-1] is a scramble of s2[j...j+len-k-1]
                        if dp[i][j + len - k][k] && dp[i + k][j][len - k] {
                            dp[i][j][len] = true;
                            break; // Found a way, no need to check other k values
                        }
                    }
                }
            }
        }

        // The result for the entire strings s1 and s2
        dp[0][0][n]
    }
}