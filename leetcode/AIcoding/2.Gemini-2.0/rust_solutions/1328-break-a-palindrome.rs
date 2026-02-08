impl Solution {
    pub fn break_palindrome(palindrome: String) -> String {
        let mut s = palindrome.chars().collect::<Vec<_>>();
        let n = s.len();

        if n <= 1 {
            return "".to_string();
        }

        for i in 0..n / 2 {
            if s[i] != 'a' {
                s[i] = 'a';
                return s.iter().collect::<String>();
            }
        }

        s[n - 1] = 'b';
        s.iter().collect::<String>()
    }
}