impl Solution {
    pub fn get_smallest_string(s: String, k: i32) -> String {
        let k = k as usize;
        let n = s.len();
        let s_bytes = s.as_bytes();

        if k == 0 {
            return String::new();
        }

        let mut distinct_suffix_chars = vec![0; n + 1];
        for i in (0..n).rev() {
            distinct_suffix_chars[i] = distinct_suffix_chars[i + 1] | (1 << (s_bytes[i] - b'a'));
        }

        let mut next_occurrence = vec![vec![n; n + 1]; 26];
        for char_code in 0..26 {
            for i in (0..n).rev() {
                if s_bytes[i] - b'a' == char_code as u8 {
                    next_occurrence[char_code][i] = i;
                } else {
                    next_occurrence[char_code][i] = next_occurrence[char_code][i + 1];
                }
            }
        }

        let mut result = String::with_capacity(k);
        let mut last_char_s_idx_for_search = 0;
        let mut used_chars_mask = 0;

        for current_len in 0..k {
            let mut found_char_for_pos = false;
            let remaining_needed = k - (current_len + 1);

            for char_code in 0..26 {
                let target_char_val = 1 << char_code;

                if (used_chars_mask & target_char_val) != 0 {
                    continue;
                }

                let current_char_s_idx = next_occurrence[char_code][last_char_s_idx_for_search];

                if current_char_s_idx == n {
                    continue;
                }

                if remaining_needed == 0 {
                    result.push((b'a' + char_code as u8) as char);
                    used_chars_mask |= target_char_val;
                    last_char_s_idx_for_search = current_char_s_idx + 1;
                    found_char_for_pos = true;
                    break;
                }

                let available_mask_for_suffix = distinct_suffix_chars[current_char_s_idx + 1];
                let current_total_used_mask = used_chars_mask | target_char_val;
                let potential_chars_mask = available_mask_for_suffix & (!current_total_used_mask);

                if potential_chars_mask.count_ones() >= remaining_needed as u32 {
                    result.push((b'a' + char_code as u8) as char);
                    used_chars_mask |= target_char_val;
                    last_char_s_idx_for_search = current_char_s_idx + 1;
                    found_char_for_pos = true;
                    break;
                }
            }

            if !found_char_for_pos {
                return String::new();
            }
        }

        result
    }
}