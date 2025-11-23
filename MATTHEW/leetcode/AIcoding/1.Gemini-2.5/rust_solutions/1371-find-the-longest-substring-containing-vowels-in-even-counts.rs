impl Solution {
    pub fn find_the_longest_substring(s: String) -> i32 {
        let n = s.len();
        // dp[mask] stores the smallest index `j` such that the prefix s[0...j-1]
        // has the vowel parity represented by `mask`.
        // We store `j` as `i + 1` from the loop, so `dp[0] = 0` means the empty prefix
        // before index 0 has a mask of 0.
        let mut dp = vec![-1; 1 << 5]; // 2^5 = 32 possible masks
        dp[0] = 0; // Initialize for the empty prefix

        let mut current_mask = 0;
        let mut max_len = 0;

        for (i, c) in s.chars().enumerate() {
            // Update the mask based on the current character
            match c {
                'a' => current_mask ^= (1 << 0),
                'e' => current_mask ^= (1 << 1),
                'i' => current_mask ^= (1 << 2),
                'o' => current_mask ^= (1 << 3),
                'u' => current_mask ^= (1 << 4),
                _ => {} // Consonants do not affect the vowel parity mask
            }

            // If this mask has been seen before
            if dp[current_mask] != -1 {
                // The substring from `dp[current_mask]` to `i` (inclusive)
                // has all vowels in even counts.
                // The length is `(current_index + 1) - (previous_index_plus_1)`.
                max_len = max_len.max((i + 1) as i32 - dp[current_mask]);
            } else {
                // If this mask is encountered for the first time, store the current
                // prefix's length (current_index + 1)
                dp[current_mask] = (i + 1) as i32;
            }
        }

        max_len
    }
}