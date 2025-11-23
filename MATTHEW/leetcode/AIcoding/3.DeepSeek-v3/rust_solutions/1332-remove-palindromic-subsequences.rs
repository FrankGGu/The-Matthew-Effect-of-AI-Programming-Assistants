impl Solution {
    pub fn remove_palindrome_sub(s: String) -> i32 {
        if s.is_empty() {
            return 0;
        }
        if s == s.chars().rev().collect::<String>() {
            return 1;
        }
        2
    }
}