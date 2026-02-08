impl Solution {
    pub fn check_palindrome(s: &String, left: i32, right: i32) -> bool {
        let mut l = left;
        let mut r = right;
        while l < r {
            if s.as_bytes()[l as usize] != s.as_bytes()[r as usize] {
                return false;
            }
            l += 1;
            r -= 1;
        }
        true
    }

    pub fn check(a: &String, b: &String) -> bool {
        let n = a.len() as i32;
        let mut i = 0;
        while i < n / 2 {
            if a.as_bytes()[i as usize] != b.as_bytes()[(n - 1 - i) as usize] {
                break;
            }
            i += 1;
        }
        if i == n / 2 {
            return true;
        }
        Self::check_palindrome(a, i, n - 1 - i) || Self::check_palindrome(b, i, n - 1 - i)
    }

    pub fn check_palindrome_formation(a: String, b: String) -> bool {
        Self::check(&a, &b) || Self::check(&b, &a)
    }
}