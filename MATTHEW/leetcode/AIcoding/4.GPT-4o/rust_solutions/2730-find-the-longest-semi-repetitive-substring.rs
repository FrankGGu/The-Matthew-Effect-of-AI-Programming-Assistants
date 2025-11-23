impl Solution {
    pub fn longest_semi_repetitive_substring(s: String) -> String {
        let bytes = s.as_bytes();
        let n = bytes.len();
        let mut max_len = 0;
        let mut start = 0;
        let mut last_seen = -1;

        for end in 0..n {
            if end > 0 && bytes[end] == bytes[end - 1] {
                start = end;
            } else if last_seen >= 0 && bytes[end] == bytes[last_seen as usize] {
                start = last_seen as usize + 1;
            }
            last_seen = end as i32;
            max_len = max_len.max(end - start + 1);
        }

        s[start..start + max_len].to_string()
    }
}