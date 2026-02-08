impl Solution {
    pub fn is_palindrome(s: &str) -> bool {
        s == s.chars().rev().collect::<String>()
    }

    pub fn first_palindrome(words: Vec<String>) -> String {
        for word in words {
            if Self::is_palindrome(&word) {
                return word;
            }
        }
        String::new()
    }
}