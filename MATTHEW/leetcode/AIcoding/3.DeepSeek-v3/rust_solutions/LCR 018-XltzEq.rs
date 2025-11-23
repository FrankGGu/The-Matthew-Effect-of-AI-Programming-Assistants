impl Solution {
    pub fn is_palindrome(s: String) -> bool {
        let s: Vec<char> = s
            .chars()
            .filter(|c| c.is_ascii_alphanumeric())
            .map(|c| c.to_ascii_lowercase())
            .collect();
        let n = s.len();
        for i in 0..n / 2 {
            if s[i] != s[n - 1 - i] {
                return false;
            }
        }
        true
    }
}