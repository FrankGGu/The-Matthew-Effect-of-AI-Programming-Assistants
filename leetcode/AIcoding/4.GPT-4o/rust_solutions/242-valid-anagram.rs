impl Solution {
    pub fn is_anagram(s: String, t: String) -> bool {
        let mut s_chars = s.chars().collect::<Vec<_>>();
        let mut t_chars = t.chars().collect::<Vec<_>>();
        s_chars.sort();
        t_chars.sort();
        s_chars == t_chars
    }
}