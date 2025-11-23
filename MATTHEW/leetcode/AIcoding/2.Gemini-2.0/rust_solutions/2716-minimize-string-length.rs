impl Solution {
    pub fn minimized_string_length(s: String) -> i32 {
        use std::collections::HashSet;
        let mut set: HashSet<char> = HashSet::new();
        for c in s.chars() {
            set.insert(c);
        }
        set.len() as i32
    }
}