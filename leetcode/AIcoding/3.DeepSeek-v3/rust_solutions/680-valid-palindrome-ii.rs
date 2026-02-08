impl Solution {
    pub fn valid_palindrome(s: String) -> bool {
        let s = s.as_bytes();
        let mut left = 0;
        let mut right = s.len() - 1;

        while left < right {
            if s[left] != s[right] {
                return Self::is_palindrome(&s[left + 1..=right]) || Self::is_palindrome(&s[left..=right - 1]);
            }
            left += 1;
            right -= 1;
        }
        true
    }

    fn is_palindrome(s: &[u8]) -> bool {
        let mut left = 0;
        let mut right = s.len() - 1;

        while left < right {
            if s[left] != s[right] {
                return false;
            }
            left += 1;
            right -= 1;
        }
        true
    }
}