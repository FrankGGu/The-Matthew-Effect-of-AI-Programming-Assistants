impl Solution {
    pub fn repeated_character(s: String) -> char {
        let mut seen = std::collections::HashSet::new();
        for c in s.chars() {
            if seen.contains(&c) {
                return c;
            }
            seen.insert(c);
        }
        ' ' // return a default value, though the problem guarantees a solution
    }
}