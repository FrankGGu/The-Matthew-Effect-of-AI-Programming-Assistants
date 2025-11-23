impl Solution {
    pub fn transformed_string_length(s: String) -> i32 {
        let mut length = 0;
        for c in s.chars() {
            if c.is_alphabetic() {
                length += 1;
            }
        }
        length
    }
}