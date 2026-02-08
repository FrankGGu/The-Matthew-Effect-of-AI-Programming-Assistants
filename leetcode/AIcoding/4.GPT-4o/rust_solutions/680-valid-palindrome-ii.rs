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

        let s_chars: Vec<char> = s.chars().collect();
        let (mut left, mut right) = (0, s.len() - 1);

        while left < right {
            if s_chars[left] != s_chars[right] {
                return is_palindrome(&s_chars, left + 1, right) || is_palindrome(&s_chars, left, right - 1);
            }
            left += 1;
            right -= 1;
        }
        true
    }
}