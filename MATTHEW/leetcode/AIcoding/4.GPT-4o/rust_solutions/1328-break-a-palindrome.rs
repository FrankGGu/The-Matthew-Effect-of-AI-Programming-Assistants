impl Solution {
    pub fn break_palindrome(palindrome: String) -> String {
        let n = palindrome.len();
        if n == 1 {
            return "".to_string();
        }

        let mut chars: Vec<char> = palindrome.chars().collect();
        for i in 0..n {
            if chars[i] != 'a' {
                chars[i] = 'a';
                return chars.iter().collect();
            }
        }

        chars[n - 1] = 'b';
        chars.iter().collect()
    }
}