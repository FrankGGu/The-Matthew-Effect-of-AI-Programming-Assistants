impl Solution {
    pub fn count_good_substrings(s: String) -> i32 {
        let s_bytes = s.as_bytes();
        let mut count = 0;
        for i in 0..s_bytes.len() - 2 {
            if s_bytes[i] != s_bytes[i + 1] && s_bytes[i] != s_bytes[i + 2] && s_bytes[i + 1] != s_bytes[i + 2] {
                count += 1;
            }
        }
        count
    }
}