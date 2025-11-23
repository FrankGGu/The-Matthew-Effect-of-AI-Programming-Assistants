struct Solution;

impl Solution {
    pub fn is_possible(s: String) -> bool {
        let s = s.as_bytes();
        let mut i = 1;
        while i < s.len() - 1 {
            if s[i] == s[i - 1] && s[i] == s[i + 1] {
                return true;
            }
            i += 1;
        }
        false
    }
}