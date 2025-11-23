impl Solution {
    pub fn max_length_between_equal_characters(s: String) -> i32 {
        let s_bytes = s.as_bytes();
        let mut max_len = -1;
        for i in 0..s_bytes.len() {
            for j in (i + 1)..s_bytes.len() {
                if s_bytes[i] == s_bytes[j] {
                    max_len = max_len.max((j - i - 1) as i32);
                }
            }
        }
        max_len
    }
}