impl Solution {
    pub fn valid_palindrome(s: String) -> bool {
        let chars: Vec<char> = s.chars().collect();
        let mut left = 0;
        let mut right = chars.len();

        if right == 0 {
            return true;
        }
        right -= 1;

        while left < right {
            if chars[left] != chars[right] {
                return Solution::is_palindrome_range(&chars, left + 1, right) ||
                       Solution::is_palindrome_range(&chars, left, right - 1);
            }
            left += 1;
            right -= 1;
        }

        true
    }

    fn is_palindrome_range(s_chars: &[char], mut left: usize, mut right: usize) -> bool {
        while left < right {
            if s_chars[left] != s_chars[right] {
                return false;
            }
            left += 1;
            right -= 1;
        }
        true
    }
}