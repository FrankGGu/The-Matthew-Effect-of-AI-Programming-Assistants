impl Solution {
    pub fn is_subsequence(s: String, t: String) -> bool {
        let mut s_chars = s.chars();
        let mut t_chars = t.chars();

        let mut current_s_char = s_chars.next();

        while let Some(tc) = t_chars.next() {
            if let Some(sc) = current_s_char {
                if tc == sc {
                    current_s_char = s_chars.next();
                }
            } else {
                return true;
            }
        }

        current_s_char.is_none()
    }
}