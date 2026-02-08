struct Solution;

impl Solution {
    pub fn restore_ip_addresses(s: String) -> Vec<String> {
        let mut result: Vec<String> = Vec::new();
        let n = s.len();

        // An IP address has 4 parts, each 1-3 digits long.
        // So, min length = 4 * 1 = 4.
        // Max length = 4 * 3 = 12.
        if n < 4 || n > 12 {
            return result;
        }

        let s_chars: Vec<char> = s.chars().collect();
        let mut current_ip_parts: Vec<String> = Vec::new();

        Self::backtrack(0, 0, &s_chars, &mut current_ip_parts, &mut result);

        result
    }

    fn is_valid_segment(segment_str: &str) -> bool {
        // A segment cannot be empty (handled by loop length 1..=3).
        // A segment cannot have leading zeros unless it is "0" itself.
        if segment_str.len() > 1 && segment_str.starts_with('0') {
            return false;
        }

        // Parse to integer and check range (0-255).
        // The problem states 's' contains only digits, so unwrap is safe.
        let num: i32 = segment_str.parse().unwrap();
        num >= 0 && num <= 255
    }

    fn backtrack(
        index: usize,
        segment_count: usize,
        s_chars: &[char],
        current_ip_parts: &mut Vec<String>,
        result: &mut Vec<String>,
    ) {
        // Base case 1: Four segments have been formed.
        if segment_count == 4 {
            // If all characters from the input string have been used, it's a valid IP.
            if index == s_chars.len() {
                result.push(current_ip_parts.join("."));
            }
            return;
        }

        // Base case 2: Ran out of characters before forming four segments.
        if index == s_chars.len() {
            return;
        }

        // Try forming segments of length 1, 2, or 3.
        for len in 1..=3 {
            // Ensure the segment does not go out of bounds of the input string.
            if index + len > s_chars.len() {
                break;
            }

            let segment_end = index + len;
            let segment_str: String = s_chars[index..segment_end].iter().collect();

            if Self::is_valid_segment(&segment_str) {
                current_ip_parts.push(segment_str);
                // Recurse with the next index and incremented segment count.
                Self::backtrack(segment_end, segment_count + 1, s_chars, current_ip_parts, result);
                current_ip_parts.pop(); // Backtrack: remove the last segment to explore other possibilities.
            }
        }
    }
}