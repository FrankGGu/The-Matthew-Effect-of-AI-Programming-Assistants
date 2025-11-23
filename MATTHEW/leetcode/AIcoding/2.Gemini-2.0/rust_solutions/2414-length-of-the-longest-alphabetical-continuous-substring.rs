impl Solution {
    pub fn longest_continuous_substring(s: String) -> i32 {
        let s_bytes = s.as_bytes();
        let mut max_len = 0;
        let mut current_len = 0;
        for i in 0..s_bytes.len() {
            if i == 0 {
                current_len = 1;
            } else {
                if s_bytes[i] as i32 == s_bytes[i - 1] as i32 + 1 {
                    current_len += 1;
                } else {
                    max_len = max_len.max(current_len);
                    current_len = 1;
                }
            }
        }
        max_len.max(current_len) as i32
    }
}