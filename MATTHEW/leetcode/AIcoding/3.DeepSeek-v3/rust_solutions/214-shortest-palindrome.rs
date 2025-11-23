impl Solution {
    pub fn shortest_palindrome(s: String) -> String {
        let rev_s: String = s.chars().rev().collect();
        let l = s.len();
        for i in 0..l {
            if s[0..l - i] == rev_s[i..] {
                return rev_s[0..i].to_string() + &s;
            }
        }
        rev_s + &s
    }
}