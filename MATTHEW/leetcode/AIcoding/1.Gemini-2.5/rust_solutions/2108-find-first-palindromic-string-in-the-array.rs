impl Solution {
    pub fn first_palindrome(words: Vec<String>) -> String {
        for word in words {
            if Self::is_palindrome(&word) {
                return word;
            }
        }
        String::new()
    }

    fn is_palindrome(s: &str) -> bool {
        let mut chars = s.chars();
        while let (Some(c1), Some(c2)) = (chars.next(), chars.next_back()) {
            if c1 != c2 {
                return false;
            }
        }
        true
    }
}