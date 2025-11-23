impl Solution {
    pub fn can_form_palindrome(s1: String, s2: String) -> bool {
        fn is_palindrome(s: &str) -> bool {
            let bytes = s.as_bytes();
            let n = bytes.len();
            for i in 0..n / 2 {
                if bytes[i] != bytes[n - 1 - i] {
                    return false;
                }
            }
            true
        }

        let s = s1 + &s2;
        for i in 0..=s.len() {
            if is_palindrome(&s[..i]) && is_palindrome(&s[i..]) {
                return true;
            }
        }
        false
    }
}