impl Solution {
    pub fn to_lower_case(s: String) -> String {
        s.chars().map(|c| {
            if c >= 'A' && c <= 'Z' {
                ((c as u8) + 32) as char
            } else {
                c
            }
        }).collect()
    }
}