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
        let bytes = s.as_bytes();
        let mut left = 0;
        let mut right = bytes.len() - 1;
        while left < right {
            if bytes[left] != bytes[right] {
                return false;
            }
            left += 1;
            right -= 1;
        }
        true
    }
}