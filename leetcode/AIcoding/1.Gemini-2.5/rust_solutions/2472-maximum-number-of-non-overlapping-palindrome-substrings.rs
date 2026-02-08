impl Solution {
    pub fn max_palindromes(s: String, k: i32) -> i32 {
        let n = s.len();
        let k = k as usize;
        let s_chars: Vec<char> = s.chars().collect();

        let mut is_palindrome = vec![vec![false; n]; n];

        // Precompute all palindrome substrings
        // is_palindrome[j][i] is true if s[j..i] is a palindrome
        for i in 0..n {
            for j in (0..=i).rev() {
                if s_chars[j] == s_chars[i] && (i - j <= 1 || is_palindrome[j + 1][i - 1]) {
                    is_palindrome[j][i] = true;
                }
            }
        }

        // dp[i] stores the maximum number of non-overlapping palindrome substrings
        // in s[0...i-1] of length at least k.
        // dp array size n+1 for convenience, mapping 0-indexed string to 1-indexed dp.
        let mut dp = vec![0; n + 1];

        for i in 1..=n { // i represents the exclusive end index for the substring s[0...i-1]
            // Option 1: Do not include any palindrome ending at index i-1.
            // In this case, the count is the same as for s[0...i-2].
            dp[i] = dp[i - 1];

            // Option 2: Try to include a palindrome s[j...i-1] ending at index i-1.
            // The length of this palindrome is (i-1) - j + 1 = i - j.
            // We need this length to be at least k, so i - j >= k, which implies j <= i - k.
            // Also, j must be a valid start index, so j >= 0.
            for j in 0..=(i - k) {
                // If s[j...i-1] is a palindrome and its length is at least k
                if is_palindrome[j][i - 1] {
                    // If we choose s[j...i-1] as a palindrome,
                    // the previous non-overlapping palindromes must be from s[0...j-1].
                    let prev_count = if j == 0 { 0 } else { dp[j] };
                    dp[i] = dp[i].max(prev_count + 1);
                }
            }
        }

        dp[n]
    }
}