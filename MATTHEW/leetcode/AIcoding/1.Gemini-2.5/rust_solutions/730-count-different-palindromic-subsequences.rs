const MOD: i32 = 1_000_000_007;

impl Solution {
    pub fn count_palindromic_subsequences(s: String) -> i32 {
        let n = s.len();
        let s_bytes = s.as_bytes();

        let mut dp = vec![vec![0; n]; n];

        // Precompute next_char_pos
        // next_char_pos[k][char_code] stores the index of the next occurrence of char_code at or after k.
        // If no occurrence, it stores n.
        // Size (n+1) x 26 to safely access next_char_pos[n]
        let mut next_char_pos = vec![vec![n as i32; 26]; n + 1];
        let mut last_seen_char_idx = vec![n as i32; 26]; // Initialized to n
        for i in (0..n).rev() {
            // For index i, the next occurrences are those stored in last_seen_char_idx
            // before updating for s_bytes[i].
            for c_code in 0..26 {
                next_char_pos[i][c_code] = last_seen_char_idx[c_code];
            }
            // Update last_seen_char_idx for the character at s_bytes[i]
            last_seen_char_idx[(s_bytes[i] - b'a') as usize] = i as i32;
        }
        // next_char_pos[n] remains all n, correctly indicating no characters after index n-1.

        // Precompute prev_char_pos
        // prev_char_pos[k][char_code] stores the index of the previous occurrence of char_code before k.
        // If no occurrence, it stores -1.
        // Size (n+1) x 26 to safely access prev_char_pos[0]
        let mut prev_char_pos = vec![vec![-1; 26]; n + 1];
        let mut first_seen_char_idx = vec![-1; 26]; // Initialized to -1
        for i in 0..n {
            // For index i+1 (representing elements before i+1), the previous occurrences are
            // those stored in first_seen_char_idx before updating for s_bytes[i].
            for c_code in 0..26 {
                prev_char_pos[i + 1][c_code] = first_seen_char_idx[c_code];
            }
            // Update first_seen_char_idx for the character at s_bytes[i]
            first_seen_char_idx[(s_bytes[i] - b'a') as usize] = i as i32;
        }
        // prev_char_pos[0] remains all -1, correctly indicating no characters before index 0.

        // Fill DP table
        // len is the length of the substring s[i..j]
        for len in 1..=n {
            for i in 0..=n - len {
                let j = i + len - 1;

                if len == 1 {
                    dp[i][j] = 1; // Single character is a palindrome
                } else {
                    if s_bytes[i] != s_bytes[j] {
                        // Palindromes from s[i+1..j] + palindromes from s[i..j-1] - palindromes from s[i+1..j-1] (to avoid double counting)
                        let mut val = dp[i + 1][j] + dp[i][j - 1];
                        val = (val - dp[i + 1][j - 1] + MOD) % MOD;
                        dp[i][j] = val;
                    } else {
                        // s_bytes[i] == s_bytes[j]
                        let char_code = (s_bytes[i] - b'a') as usize;

                        // next_i: first occurrence of s[i] in s[i+1..n-1]
                        let next_i = next_char_pos[i + 1][char_code];
                        // prev_j: last occurrence of s[j] in s[0..j-1]
                        let prev_j = prev_char_pos[j][char_code];

                        if next_i > prev_j {
                            // Case 1: No s[i] (or s[j]) in s[i+1..j-1]
                            // Palindromes are:
                            // 1. All palindromes from s[i+1..j-1] (dp[i+1][j-1])
                            // 2. All palindromes of the form s[i] X s[j], where X is a palindrome from s[i+1..j-1] (dp[i+1][j-1])
                            // 3. The single character s[i] (1)
                            // 4. The two-character palindrome s[i]s[j] (1)
                            // Total: 2 * dp[i+1][j-1] + 2
                            dp[i][j] = (2 * dp[i + 1][j - 1] + 2) % MOD;
                        } else if next_i == prev_j {
                            // Case 2: Exactly one s[i] (or s[j]) in s[i+1..j-1] (at index next_i/prev_j)
                            // Palindromes are:
                            // 1. All palindromes from s[i+1..j-1] (dp[i+1][j-1])
                            // 2. All palindromes of the form s[i] X s[j], where X is a palindrome from s[i+1..j-1] (dp[i+1][j-1])
                            // 3. The single character s[i] (1)
                            // The palindrome s[i]s[j] is covered by s[i] X s[j] where X is s[next_i] if s[next_i] is empty.
                            // The single character s[next_i] is covered by s[i] X s[j] where X is the single character s[next_i].
                            // Total: 2 * dp[i+1][j-1] + 1
                            dp[i][j] = (2 * dp[i + 1][j - 1] + 1) % MOD;
                        } else {
                            // Case 3: Multiple s[i] (or s[j]) in s[i+1..j-1]
                            // Palindromes are:
                            // 1. All palindromes from s[i+1..j-1] (dp[i+1][j-1])
                            // 2. All palindromes of the form s[i] X s[j], where X is a palindrome from s[i+1..j-1] (dp[i+1][j-1])
                            // We need to subtract palindromes that are double counted. These are palindromes
                            // of the form s[i] Y s[j] where Y is a palindrome from s[next_i+1..prev_j-1].
                            // The count of such Y is dp[next_i+1][prev_j-1].
                            // Total: 2 * dp[i+1][j-1] - dp[next_i+1][prev_j-1]
                            let mut val = 2 * dp[i + 1][j - 1];
                            val = (val - dp[next_i as usize + 1][prev_j as usize - 1] + MOD) % MOD;
                            dp[i][j] = val;
                        }
                    }
                }
            }
        }

        dp[0][n - 1]
    }
}