impl Solution {
    pub fn smallest_substring(s: String) -> String {
        let s_chars: Vec<char> = s.chars().collect();
        let mut min_len = usize::MAX;
        let mut result = String::new();

        for i in 0..s_chars.len() {
            let current_char = s_chars[i];
            let mut j = i;
            while j < s_chars.len() && s_chars[j] == current_char {
                j += 1;
            }
            let len = j - i;
            if len < min_len || (len == min_len && &s[i..j] < &result) {
                min_len = len;
                result = s[i..j].to_string();
            }
        }

        result
    }
}