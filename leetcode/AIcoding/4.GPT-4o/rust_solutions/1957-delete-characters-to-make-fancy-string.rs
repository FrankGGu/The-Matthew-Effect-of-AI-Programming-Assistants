impl Solution {
    pub fn make_fancy_string(s: String) -> String {
        let mut result = String::new();
        let mut count = 1;
        let mut prev_char = '\0';

        for c in s.chars() {
            if c == prev_char {
                count += 1;
            } else {
                count = 1;
                prev_char = c;
            }
            if count < 3 {
                result.push(c);
            }
        }

        result
    }
}