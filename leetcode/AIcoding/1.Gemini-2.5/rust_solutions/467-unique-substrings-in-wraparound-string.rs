impl Solution {
    pub fn find_substring_in_wrapround_string(p: String) -> i32 {
        if p.is_empty() {
            return 0;
        }

        let mut dp = vec![0; 26]; // dp[i] stores the maximum length of a valid substring ending with the i-th character ('a' + i)
        let mut current_len = 0;
        let p_chars: Vec<char> = p.chars().collect();

        for i in 0..p_chars.len() {
            let char_code = (p_chars[i] as u8 - b'a') as usize;

            if i > 0 {
                let prev_char_code = (p_chars[i - 1] as u8 - b'a') as usize;
                // Check if the current character follows the previous character in the wraparound string.
                // For example, 'b' follows 'a', 'a' follows 'z'.
                // (char_code - prev_char_code + 26) % 26 == 1
                if (char_code as i32 - prev_char_code as i32 + 26) % 26 == 1 {
                    current_len += 1;
                } else {
                    current_len = 1;
                }
            } else {
                // The first character always starts a new sequence of length 1.
                current_len = 1;
            }

            // Update the maximum length for substrings ending with this character.
            // If we found a longer valid substring ending with this character, update dp.
            dp[char_code] = dp[char_code].max(current_len);
        }

        // The total number of unique substrings is the sum of all maximum lengths.
        // For each character 'x', if dp['x'] is L, it means we found L unique substrings
        // ending with 'x': 'x', '...x', '....x' (of length L).
        // By taking the maximum length for each ending character, we ensure that
        // all unique substrings are counted exactly once.
        dp.iter().sum()
    }
}