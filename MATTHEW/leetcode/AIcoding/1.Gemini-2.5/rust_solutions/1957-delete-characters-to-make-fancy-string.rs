impl Solution {
    pub fn make_fancy_string(s: String) -> String {
        let mut result_chars: Vec<char> = Vec::new();

        for c in s.chars() {
            if result_chars.len() >= 2
                && result_chars[result_chars.len() - 1] == c
                && result_chars[result_chars.len() - 2] == c
            {
                continue;
            } else {
                result_chars.push(c);
            }
        }

        result_chars.into_iter().collect()
    }
}