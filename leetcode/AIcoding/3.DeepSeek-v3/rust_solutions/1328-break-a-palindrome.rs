impl Solution {
    pub fn break_palindrome(palindrome: String) -> String {
        let mut chars: Vec<char> = palindrome.chars().collect();
        let n = chars.len();
        if n == 1 {
            return String::new();
        }
        for i in 0..n / 2 {
            if chars[i] != 'a' {
                chars[i] = 'a';
                return chars.into_iter().collect();
            }
        }
        chars[n - 1] = 'b';
        chars.into_iter().collect()
    }
}