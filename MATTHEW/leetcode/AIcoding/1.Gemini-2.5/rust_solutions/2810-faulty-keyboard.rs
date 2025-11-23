impl Solution {
    pub fn final_string(s: String) -> String {
        let mut result_chars: Vec<char> = Vec::new();

        for ch in s.chars() {
            if ch == 'i' {
                result_chars.reverse();
            } else {
                result_chars.push(ch);
            }
        }

        result_chars.into_iter().collect()
    }
}