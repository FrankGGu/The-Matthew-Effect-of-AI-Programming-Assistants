use std::collections::HashMap;

impl Solution {
    pub fn min_window(s: String, t: String) -> String {
        if t.is_empty() {
            return "".to_string();
        }

        let s_bytes = s.as_bytes();
        let t_bytes = t.as_bytes();

        let mut t_counts = [0; 128];
        for &ch_byte in t_bytes {
            t_counts[ch_byte as usize] += 1;
        }

        let mut window_counts = [0; 128];
        let mut formed = 0; // Number of distinct characters in t that are present in the current window with at least their required frequency

        let mut required_distinct_chars = 0;
        for &count in t_counts.iter() {
            if count > 0 {
                required_distinct_chars += 1;
            }
        }

        let mut min_len = usize::MAX;
        let mut ans_l = 0;
        let mut ans_r = 0; // Exclusive end index

        let mut l = 0;
        for r in 0..s_bytes.len() {
            let r_char_byte = s_bytes[r];
            window_counts[r_char_byte as usize] += 1;

            // If the current character is part of t and its count in window now matches t's count, increment formed
            if t_counts[r_char_byte as usize] > 0 && window_counts[r_char_byte as usize] == t_counts[r_char_byte as usize] {
                formed += 1;
            }

            // Try to shrink the window from the left as long as all required characters are formed
            while formed == required_distinct_chars {
                let current_window_len = r - l + 1;
                if current_window_len < min_len {
                    min_len = current_window_len;
                    ans_l = l;
                    ans_r = r + 1; // Store exclusive end index
                }

                let l_char_byte = s_bytes[l];
                window_counts[l_char_byte as usize] -= 1;

                // If the character removed was part of t and its count in window drops below t's count, decrement formed
                if t_counts[l_char_byte as usize] > 0 && window_counts[l_char_byte as usize] < t_counts[l_char_byte as usize] {
                    formed -= 1;
                }
                l += 1;
            }
        }

        if min_len == usize::MAX {
            "".to_string()
        } else {
            String::from_utf8(s_bytes[ans_l..ans_r].to_vec()).unwrap()
        }
    }
}