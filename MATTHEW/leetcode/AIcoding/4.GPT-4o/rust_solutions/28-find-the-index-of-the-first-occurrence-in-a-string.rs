impl Solution {
    pub fn str_str(haystack: String, needle: String) -> i32 {
        if needle.is_empty() {
            return 0;
        }
        let h_len = haystack.len();
        let n_len = needle.len();
        if h_len < n_len {
            return -1;
        }
        for i in 0..=h_len - n_len {
            if &haystack[i..i + n_len] == &needle {
                return i as i32;
            }
        }
        -1
    }
}