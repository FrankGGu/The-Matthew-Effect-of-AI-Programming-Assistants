impl Solution {
    pub fn remove_trailing_zeros(s: String) -> String {
        s.trim_end_matches('0').to_string()
    }
}