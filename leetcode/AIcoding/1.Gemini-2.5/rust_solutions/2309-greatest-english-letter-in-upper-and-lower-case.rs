use std::collections::HashSet;

impl Solution {
    pub fn greatest_letter(s: String) -> String {
        let char_set: HashSet<char> = s.chars().collect();

        for c_upper in ('A'..='Z').rev() {
            let c_lower = c_upper.to_ascii_lowercase();
            if char_set.contains(&c_upper) && char_set.contains(&c_lower) {
                return c_upper.to_string();
            }
        }

        String::new()
    }
}