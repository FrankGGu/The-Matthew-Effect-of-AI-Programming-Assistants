use std::cmp::max;

impl Solution {
    pub fn character_replacement(s: String, k: i32) -> i32 {
        let chars: Vec<char> = s.chars().collect();
        let n = chars.len();
        let mut freq = vec![0; 26]; // Frequency of characters 'A' through 'Z'
        let mut left = 0;
        let mut max_freq = 0; // Maximum frequency of any character in the current window
        let mut max_len = 0;  // Longest valid substring length

        for right in 0..n {
            let char_code = (chars[right] as u8 - b'A') as usize;
            freq[char_code] += 1;
            max_freq = max(max_freq, freq[char_code]);

            // Current window length
            let current_window_length = (right - left + 1) as i32;

            // If the number of characters to replace (current_window_length - max_freq)
            // exceeds k, then we need to shrink the window from the left.
            if current_window_length - max_freq > k {
                let left_char_code = (chars[left] as u8 - b'A') as usize;
                freq[left_char_code] -= 1;
                left += 1;
                // Note: max_freq is NOT re-calculated here.
                // It retains the maximum frequency seen so far in any valid window.
                // This works because we are looking for the *longest* window.
                // If a window of length L is invalid (needs > k replacements),
                // then any window of length L' > L that includes the current `max_freq` character
                // will also be invalid. By keeping `max_freq` high, we ensure `left` only moves
                // when absolutely necessary, thus maximizing the window length.
            }

            // The current window [left..right] is always a candidate for the longest valid substring.
            // If the `if` condition was met, `left` moved, making the window shorter.
            // If the `if` condition was not met, the window expanded, and it's still valid.
            // In either case, `right - left + 1` represents the length of the current valid window.
            max_len = max(max_len, (right - left + 1) as i32);
        }

        max_len
    }
}