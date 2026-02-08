impl Solution {
    pub fn remove_adjacent_characters(s: String) -> String {
        let mut result = String::new();
        let mut prev_char = '\0';

        for c in s.chars() {
            if c != prev_char {
                result.push(c);
                prev_char = c;
            }
        }

        result
    }
}