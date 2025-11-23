impl Solution {
    pub fn append_characters(s: String, t: String) -> i32 {
        let s_chars: Vec<char> = s.chars().collect();
        let t_chars: Vec<char> = t.chars().collect();
        let mut i = 0;
        let mut j = 0;
        let s_len = s_chars.len();
        let t_len = t_chars.len();

        while i < s_len && j < t_len {
            if s_chars[i] == t_chars[j] {
                j += 1;
            }
            i += 1;
        }

        (t_len - j) as i32
    }
}