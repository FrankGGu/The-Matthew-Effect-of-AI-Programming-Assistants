impl Solution {
    pub fn longest_continuous_substring(s: String) -> i32 {
        let s = s.as_bytes();
        let mut max_len = 1;
        let mut current_len = 1;

        for i in 1..s.len() {
            if s[i] == s[i - 1] + 1 {
                current_len += 1;
                max_len = max_len.max(current_len);
            } else {
                current_len = 1;
            }
        }

        max_len
    }
}