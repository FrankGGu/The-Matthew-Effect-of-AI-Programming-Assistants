impl Solution {
    pub fn minimize_string_length(s: String) -> i32 {
        let unique_chars: std::collections::HashSet<char> = s.chars().collect();
        unique_chars.len() as i32
    }
}