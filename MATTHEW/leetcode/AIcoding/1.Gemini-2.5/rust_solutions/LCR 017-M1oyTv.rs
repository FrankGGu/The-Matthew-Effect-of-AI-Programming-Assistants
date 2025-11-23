impl Solution {
    pub fn min_window(s: String, t: String) -> String {
        if t.is_empty() {
            return "".to_string();
        }

        let s_bytes = s.as_bytes();
        let t_bytes = t.as_bytes();

        let mut t_freq = [0; 128]; // Frequency map for characters in t
        for &c in t_bytes {
            t_freq[c as usize] += 1;
        }

        let mut window_freq = [0; 128]; // Frequency map for characters in the current window
        let mut left = 0;
        let mut min_len = usize::MAX;
        let mut min_start = 0;
        let mut match_count = 0; // Number of characters (with multiplicity) from t that are currently matched in the window

        for right in 0..s_bytes.len() {
            let char_r = s_bytes[right];

            // Only process characters that are relevant to t
            if t_freq[char_r as usize] > 0 {
                window_freq[char_r as usize] += 1;
                // If the count of char_r in the window is less than or equal to its required count in t,
                // it means we've successfully added a character needed for the match.
                if window_freq[char_r as usize] <= t_freq[char_r as usize] {
                    match_count += 1;
                }
            }

            // While the window is valid (all characters from t are matched)
            while match_count == t_bytes.len() {
                let current_len = right - left + 1;
                if current_len < min_len {
                    min_len = current_len;
                    min_start = left;
                }

                let char_l = s_bytes[left];

                // Only process characters that are relevant to t
                if t_freq[char_l as usize] > 0 {
                    // If the count of char_l in the window was less than or equal to its required count in t,
                    // it means this character was contributing to the match_count.
                    // Now that we're removing it, we decrement match_count.
                    if window_freq[char_l as usize] <= t_freq[char_l as usize] {
                        match_count -= 1;
                    }
                    window_freq[char_l as usize] -= 1;
                }
                left += 1;
            }
        }

        if min_len == usize::MAX {
            "".to_string()
        } else {
            // Convert the slice of bytes back to a String.
            // This is safe because the original `s` is a valid String,
            // and we are slicing its bytes.
            String::from_utf8(s_bytes[min_start..(min_start + min_len)].to_vec()).unwrap()
        }
    }
}