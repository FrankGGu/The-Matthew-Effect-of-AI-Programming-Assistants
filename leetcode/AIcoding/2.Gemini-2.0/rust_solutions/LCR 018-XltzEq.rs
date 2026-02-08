impl Solution {
    pub fn is_palindrome(s: String) -> bool {
        let s = s.chars().filter(|c| c.is_alphanumeric()).map(|c| c.to_lowercase().next().unwrap()).collect::<String>();
        let n = s.len();
        for i in 0..n / 2 {
            if s.chars().nth(i) != s.chars().nth(n - 1 - i) {
                return false;
            }
        }
        true
    }
}