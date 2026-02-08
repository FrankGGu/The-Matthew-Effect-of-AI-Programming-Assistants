impl Solution {
    fn is_palindrome_vec(chars: &[char]) -> bool {
        let n = chars.len();
        if n == 0 {
            return true;
        }
        let mut l = 0;
        let mut r = n - 1;
        while l < r {
            if chars[l] != chars[r] {
                return false;
            }
            l += 1;
            r -= 1;
        }
        true
    }

    fn check_palindrome_split(s1: &str, s2: &str) -> bool {
        let n = s1.len();
        if n == 0 {
            return true;
        }

        let s1_chars: Vec<char> = s1.chars().collect();
        let s2_chars: Vec<char> = s2.chars().collect();

        let mut l = 0;
        let mut r = n - 1;

        while l < r && s1_chars[l] == s2_chars[r] {
            l += 1;
            r -= 1;
        }

        Self::is_palindrome_vec(&s1_chars[l..=r]) || Self::is_palindrome_vec(&s2_chars[l..=r])
    }

    pub fn check_palindrome_formation(a: String, b: String) -> bool {
        Self::check_palindrome_split(&a, &b) || Self::check_palindrome_split(&b, &a)
    }
}