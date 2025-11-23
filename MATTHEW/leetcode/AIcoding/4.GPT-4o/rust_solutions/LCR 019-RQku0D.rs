impl Solution {
    pub fn valid_palindrome(s: String) -> bool {
        fn is_palindrome(s: &[char], left: usize, right: usize) -> bool {
            while left < right {
                if s[left] != s[right] {
                    return false;
                }
                left += 1;
                right -= 1;
            }
            true
        }

        let chars: Vec<char> = s.chars().collect();
        let (mut left, mut right) = (0, chars.len() - 1);

        while left < right {
            if chars[left] != chars[right] {
                return is_palindrome(&chars, left + 1, right) || is_palindrome(&chars, left, right - 1);
            }
            left += 1;
            right -= 1;
        }
        true
    }
}