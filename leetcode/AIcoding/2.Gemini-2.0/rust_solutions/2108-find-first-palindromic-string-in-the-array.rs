impl Solution {
    pub fn first_palindrome(words: Vec<String>) -> String {
        for word in words {
            if Solution::is_palindrome(&word) {
                return word;
            }
        }
        return "".to_string();
    }

    fn is_palindrome(s: &String) -> bool {
        let chars: Vec<char> = s.chars().collect();
        let n = chars.len();
        for i in 0..n / 2 {
            if chars[i] != chars[n - 1 - i] {
                return false;
            }
        }
        return true;
    }
}