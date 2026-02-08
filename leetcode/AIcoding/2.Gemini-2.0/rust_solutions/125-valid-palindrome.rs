impl Solution {
    pub fn is_palindrome(s: String) -> bool {
        let cleaned_s: String = s.chars()
            .filter(|c| c.is_alphanumeric())
            .map(|c| c.to_lowercase().to_string())
            .collect::<String>();

        let reversed_s: String = cleaned_s.chars().rev().collect::<String>();

        cleaned_s == reversed_s
    }
}