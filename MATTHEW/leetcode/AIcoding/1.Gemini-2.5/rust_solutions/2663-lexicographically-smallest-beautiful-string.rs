struct Solution;

impl Solution {
    pub fn smallest_beautiful_string(s: String, k: i32) -> String {
        let n = s.len();
        let mut chars: Vec<char> = s.chars().collect();
        let k_char_max = ('a' as u8 + k as u8 - 1) as char;

        // Iterate from the rightmost character
        for i in (0..n).rev() {
            // Try to increment chars[i]
            // Start checking from the character immediately after chars[i]
            // and go up to k_char_max.
            for c_val in (chars[i] as u8 + 1)..=(k_char_max as u8) {
                let c = c_val as char;

                // Check conditions for c at position i
                let mut is_valid_char_for_pos = true;

                // Condition 2: No two consecutive characters are the same
                if i > 0 && c == chars[i - 1] {
                    is_valid_char_for_pos = false;
                }
                // Condition 3: No three consecutive characters are the same
                // This means 'c' cannot be equal to chars[i-2] if chars[i-1] is also equal to chars[i-2]
                if is_valid_char_for_pos && i > 1 && c == chars[i - 2] && chars[i - 1] == chars[i - 2] {
                    is_valid_char_for_pos = false;
                }

                if is_valid_char_for_pos {
                    chars[i] = c;

                    // Fill subsequent positions (i+1 to n-1) with the lexicographically smallest valid characters
                    for j in (i + 1)..n {
                        // Try 'a', 'b', 'c', ... up to k_char_max
                        for fill_c_val in 'a' as u8..=(k_char_max as u8) {
                            let fill_c = fill_c_val as char;

                            let mut fill_is_valid_char_for_pos = true;

                            // Condition 2: fill_c != chars[j-1]
                            if j > 0 && fill_c == chars[j - 1] {
                                fill_is_valid_char_for_pos = false;
                            }
                            // Condition 3: fill_c != chars[j-2] if chars[j-1] == chars[j-2]
                            if fill_is_valid_char_for_pos && j > 1 && fill_c == chars[j - 2] && chars[j - 1] == chars[j - 2] {
                                fill_is_valid_char_for_pos = false;
                            }

                            if fill_is_valid_char_for_pos {
                                chars[j] = fill_c;
                                break; // Found smallest valid char for this position, move to next j
                            }
                        }
                    }
                    return chars.into_iter().collect();
                }
            }
        }

        // If no such string is found after trying all possibilities
        String::new()
    }
}