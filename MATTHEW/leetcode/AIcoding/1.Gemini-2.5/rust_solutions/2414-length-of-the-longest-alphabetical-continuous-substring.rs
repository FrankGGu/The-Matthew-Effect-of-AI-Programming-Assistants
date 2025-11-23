impl Solution {
    pub fn longest_continuous_substring(s: String) -> i32 {
        if s.is_empty() {
            return 0;
        }

        let chars: Vec<char> = s.chars().collect();
        let mut max_len = 1;
        let mut current_len = 1;

        for i in 1..chars.len() {
            if (chars[i] as u8) == (chars[i - 1] as u8 + 1) {
                current_len += 1;
            } else {
                current_len = 1;
            }
            max_len = max_len.max(current_len);
        }

        max_len
    }
}