impl Solution {
    pub fn check_palindrome_formation(a: String, b: String) -> bool {
        let a_bytes = a.as_bytes();
        let b_bytes = b.as_bytes();
        let n = a_bytes.len();

        Self::check(a_bytes, b_bytes) || Self::check(b_bytes, a_bytes)
    }

    fn check(a: &[u8], b: &[u8]) -> bool {
        let n = a.len();
        let mut left = 0;
        let mut right = n - 1;

        while left < right && a[left] == b[right] {
            left += 1;
            right -= 1;
        }

        if left >= right {
            return true;
        }

        Self::is_palindrome(&a[left..=right]) || Self::is_palindrome(&b[left..=right])
    }

    fn is_palindrome(s: &[u8]) -> bool {
        let n = s.len();
        for i in 0..n / 2 {
            if s[i] != s[n - 1 - i] {
                return false;
            }
        }
        true
    }
}