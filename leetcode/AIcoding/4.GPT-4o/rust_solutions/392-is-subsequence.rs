impl Solution {
    pub fn is_subsequence(s: String, t: String) -> bool {
        let mut s_iter = s.chars();
        let mut s_char = s_iter.next();

        for char in t.chars() {
            if s_char == Some(char) {
                s_char = s_iter.next();
            }
            if s_char.is_none() {
                return true;
            }
        }

        s_char.is_none()
    }
}