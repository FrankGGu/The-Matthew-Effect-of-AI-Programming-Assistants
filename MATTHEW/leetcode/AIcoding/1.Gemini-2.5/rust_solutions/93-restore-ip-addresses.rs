impl Solution {
    pub fn restore_ip_addresses(s: String) -> Vec<String> {
        let mut results: Vec<String> = Vec::new();
        let mut current_ip_parts: Vec<String> = Vec::new();
        let s_chars: Vec<char> = s.chars().collect();

        Self::backtrack(&s_chars, 0, &mut current_ip_parts, &mut results);

        results
    }

    fn backtrack(
        s_chars: &[char],
        start_index: usize,
        current_ip_parts: &mut Vec<String>,
        results: &mut Vec<String>,
    ) {
        if current_ip_parts.len() == 4 {
            if start_index == s_chars.len() {
                results.push(current_ip_parts.join("."));
            }
            return;
        }

        let remaining_segments = 4 - current_ip_parts.len();
        let remaining_chars = s_chars.len() - start_index;

        if remaining_chars < remaining_segments || remaining_chars > remaining_segments * 3 {
             return;
        }

        for i in start_index..s_chars.len() {
            if i - start_index + 1 > 3 {
                break;
            }

            let segment_str: String = s_chars[start_index..=i].iter().collect();

            if Self::is_valid_segment(&segment_str) {
                current_ip_parts.push(segment_str);
                Self::backtrack(s_chars, i + 1, current_ip_parts, results);
                current_ip_parts.pop();
            }
        }
    }

    fn is_valid_segment(segment_str: &str) -> bool {
        if segment_str.is_empty() {
            return false;
        }
        if segment_str.len() > 1 && segment_str.starts_with('0') {
            return false;
        }
        match segment_str.parse::<u8>() {
            Ok(_) => true,
            Err(_) => false,
        }
    }
}