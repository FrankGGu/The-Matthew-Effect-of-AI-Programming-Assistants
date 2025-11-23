impl Solution {
    pub fn is_palindrome(s: String) -> bool {
        let s = s.chars().filter(|c| c.is_alphanumeric()).collect::<String>();
        let s = s.to_lowercase();
        let len = s.len();
        for i in 0..len / 2 {
            if s.as_bytes()[i] != s.as_bytes()[len - 1 - i] {
                return false;
            }
        }
        true
    }
}