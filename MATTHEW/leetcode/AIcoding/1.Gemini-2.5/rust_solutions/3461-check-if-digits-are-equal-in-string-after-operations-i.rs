impl Solution {
    pub fn check_if_digits_are_equal_in_string_after_operations(s: String) -> bool {
        let first_char = s.chars().next().unwrap();
        for c in s.chars() {
            if c != first_char {
                return false;
            }
        }
        true
    }
}