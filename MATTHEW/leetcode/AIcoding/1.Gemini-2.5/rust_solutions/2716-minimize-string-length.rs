use std::collections::HashSet;

impl Solution {
    pub fn minimized_string_length(s: String) -> i32 {
        let mut unique_chars: HashSet<char> = HashSet::new();
        for c in s.chars() {
            unique_chars.insert(c);
        }
        unique_chars.len() as i32
    }
}