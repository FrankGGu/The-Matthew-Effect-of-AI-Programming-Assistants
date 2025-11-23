struct Solution;

impl Solution {
    pub fn is_palindrome(s: String) -> bool {
        let s = s.to_lowercase();
        let mut left = 0;
        let mut right = s.len() - 1;

        while left < right {
            let left_char = s.chars().nth(left).unwrap();
            let right_char = s.chars().nth(right).unwrap();

            if !left_char.is_alphanumeric() {
                left += 1;
                continue;
            }

            if !right_char.is_alphanumeric() {
                right -= 1;
                continue;
            }

            if left_char != right_char {
                return false;
            }

            left += 1;
            right -= 1;
        }

        true
    }
}