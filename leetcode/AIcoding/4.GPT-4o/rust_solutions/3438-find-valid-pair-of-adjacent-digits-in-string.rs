impl Solution {
    pub fn has_valid_pair(s: String) -> bool {
        let bytes = s.as_bytes();
        for i in 0..bytes.len() - 1 {
            if (bytes[i] as char).is_digit(10) && (bytes[i + 1] as char).is_digit(10) {
                return true;
            }
        }
        false
    }
}