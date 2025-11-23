impl Solution {
    pub fn longest_palindromic_subsequence_after_at_most_k_operations(s: String, k: i32) -> i32 {
        let n = s.len();
        let chars: Vec<u8> = s.into_bytes();

        // dp[i][j][cost] stores the maximum length of a palindromic subsequence
        // for the substring s[i..j] using exactly 'cost' character changes.
        // The maximum possible cost to consider is `k`.
        let max_k_val = k as usize;

        // dp table dimensions: [start_index][end_index][cost]
        // Initialize with 0, as 0 is the minimum possible length.
        let mut dp = vec![vec![vec![0; max_k_val + 1]; n]; n];

        // Base cases: single characters are palindromes of length 1 with 0 cost.
        for i in 0..n {
            dp[i][i][0] = 1;
        }

        // Fill the DP table
        // 'len' is the length of the current substring (j - i + 1)
        for len in 2..=n {
            for i in 0..=(n - len) {
                let j = i + len - 1; // Calculate the end index 'j'
                for current_k_val in 0..=max_k_val {
                    // Option 1: Consider s[i] and s[j] as the outermost characters of the palindrome.
                    // Calculate the cost to make them match.
                    let cost_to_match = if chars[i] == chars[j] { 0 } else { 1 };

                    if current_k_val >= cost_to_match {
                        // If we have enough operations, we can form a palindrome using s[i] and s[j].
                        // The length will be 2 (for s[i] and s[j]) plus the length of the
                        // palindromic subsequence of s[i+1..j-1] using remaining operations.
                        let inner_subsequence_len = if i + 1 <= j - 1 {
                            // If there's a valid inner substring, use its DP value.
                            dp[i + 1][j - 1][current_k_val - cost_to_match]
                        } else {
                            // If i+1 > j-1, it means the inner substring is empty (e.g., len 2 or 1).
                            // An empty string has a palindromic subsequence length of 0.
                            0
                        };
                        dp[i][j][current_k_val] = dp[i][j][current_k_val].max(inner_subsequence_len + 2);
                    }

                    // Option 2: Skip s[i] and find the LPS in s[i+1..j]
                    dp[i][j][current_k_val] = dp[i][j][current_k_val].max(dp[i + 1][j][current_k_val]);

                    // Option 3: Skip s[j] and find the LPS in s[i..j-1]
                    dp[i][j][current_k_val] = dp[i][j][current_k_val].max(dp[i][j - 1][current_k_val]);
                }
            }
        }

        // The final answer is the maximum length found for the entire string s[0..n-1]
        // using at most K operations. We iterate through all allowed costs up to max_k_val.
        let mut max_len = 0;
        for current_k_val in 0..=max_k_val {
            max_len = max_len.max(dp[0][n - 1][current_k_val]);
        }

        max_len
    }
}