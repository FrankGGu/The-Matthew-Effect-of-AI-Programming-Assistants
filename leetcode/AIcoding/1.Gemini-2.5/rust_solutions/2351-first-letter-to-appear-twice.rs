use std::collections::HashSet;

impl Solution {
    pub fn repeated_character(s: String) -> char {
        let mut seen_chars: HashSet<char> = HashSet::new();

        for c in s.chars() {
            if seen_chars.contains(&c) {
                return c;
            }
            seen_chars.insert(c);
        }

        // This line should technically not be reached given the problem constraints
        // (guaranteed that there will be a repeated character).
        // However, Rust requires all paths to return a value.
        s.chars().next().unwrap() 
    }
}