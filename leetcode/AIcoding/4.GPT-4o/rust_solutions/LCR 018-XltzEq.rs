impl Solution {
    pub fn is_palindrome(s: String) -> bool {
        let filtered: String = s.chars()
            .filter(|c| c.is_alphanumeric())
            .map(|c| c.to_ascii_lowercase())
            .collect();
        filtered == filtered.chars().rev().collect::<String>()
    }
}