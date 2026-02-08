use std::collections::HashSet;
use std::cmp::max;

impl Solution {
    pub fn longest_valid_substring(s: String, forbidden: Vec<String>) -> i32 {
        let forbidden_set: HashSet<String> = forbidden.into_iter().collect();
        let n = s.len();

        let mut max_len = 0;
        let mut left = 0; // 'left' is the starting byte index of the current valid window.

        for right in 0..n { // 'right' is the ending byte index of the current window.
            // Check suffixes ending at 'right' for forbidden words.
            // Iterate 'k' from 1 (shortest suffix) up to 10 (maximum forbidden word length).
            // This ensures that if multiple forbidden words end at 'right',
            // 'left' is correctly updated to exclude the one that forces it furthest to the right.
            for k in 1..=10 {
                let start_idx = right - k + 1; // Calculate the starting index of the current suffix.

                // If the suffix starts before the current valid window's left boundary,
                // it means this suffix (and any longer ones for increasing k) is not part of s[left..right].
                // So, we can stop checking longer suffixes.
                if start_idx < left {
                    break;
                }

                // Extract the suffix as a string slice.
                // Since 's' consists of lowercase English letters, byte indexing is safe.
                let current_suffix = &s[start_idx..=right];

                // If this suffix is a forbidden word, we must adjust 'left'.
                if forbidden_set.contains(current_suffix) {
                    // The forbidden word is s[start_idx..=right].
                    // To make the window valid, 'left' must be moved past 'start_idx'.
                    // So, the new 'left' must be at least 'start_idx + 1'.
                    // We take the maximum to ensure 'left' is moved to the furthest necessary position
                    // due to any forbidden suffix ending at 'right'.
                    left = max(left, start_idx + 1);
                }
            }

            // After checking all relevant suffixes for the current 'right',
            // the window s[left..right] is guaranteed to be valid.
            // Calculate its length and update 'max_len'.
            max_len = max(max_len, (right - left + 1) as i32);
        }

        max_len
    }
}