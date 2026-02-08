impl Solution {
    pub fn valid_palindrome(s: String) -> bool {
        let s_bytes = s.as_bytes();
        let mut left = 0;
        let mut right = s_bytes.len() - 1;

        let is_palindrome_range = |mut l: usize, mut r: usize| -> bool {
            while l < r {
                if s_bytes[l] != s_bytes[r] {
                    return false;
                }
                l += 1;
                r -= 1;
            }
            true
        };

        while left < right {
            if s_bytes[left] == s_bytes[right] {
                left += 1;
                right -= 1;
            } else {
                return is_palindrome_range(left + 1, right) || is_palindrome_range(left, right - 1);
            }
        }

        true
    }
}