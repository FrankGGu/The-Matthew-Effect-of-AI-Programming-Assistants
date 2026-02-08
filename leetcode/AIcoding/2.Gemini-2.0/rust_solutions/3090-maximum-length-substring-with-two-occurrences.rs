impl Solution {
    pub fn max_length_between_equal_characters(s: String) -> i32 {
        let mut max_len = -1;
        let chars: Vec<char> = s.chars().collect();
        for i in 0..chars.len() {
            for j in (i + 1)..chars.len() {
                if chars[i] == chars[j] {
                    max_len = max_len.max((j - i - 1) as i32);
                }
            }
        }
        max_len
    }
}