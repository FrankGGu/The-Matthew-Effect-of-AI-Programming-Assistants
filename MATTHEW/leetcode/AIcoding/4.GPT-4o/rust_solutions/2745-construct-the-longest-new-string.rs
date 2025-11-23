impl Solution {
    pub fn longest_new_string(s: String) -> String {
        let mut result = String::new();
        let mut last_char = '\0';

        for c in s.chars() {
            if c != last_char {
                result.push(c);
                last_char = c;
            }
        }

        result
    }
}