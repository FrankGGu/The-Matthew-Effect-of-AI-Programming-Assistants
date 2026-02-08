impl Solution {
    pub fn to_lower_case(s: String) -> String {
        s.chars().map(|c| c.to_ascii_lowercase()).collect()
    }
}