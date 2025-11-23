impl Solution {
    pub fn prefix_count(s: String, prefix: String) -> i32 {
        let mut count = 0;
        let p_len = prefix.len();
        for i in 0..s.len() {
            if s[i..].starts_with(&prefix) {
                count += 1;
            }
            if i + p_len >= s.len() {
                break;
            }
        }
        count
    }
}