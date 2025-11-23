impl Solution {
    pub fn match_substring(s: String, sub: String, replacements: Vec<String>) -> bool {
        let mut s_iter = s.chars();
        let mut sub_iter = sub.chars();

        let mut s_char = s_iter.next();
        let mut sub_char = sub_iter.next();

        while let (Some(s_c), Some(sub_c)) = (s_char, sub_char) {
            if s_c == sub_c {
                s_char = s_iter.next();
                sub_char = sub_iter.next();
            } else if replacements.contains(&s_c.to_string()) {
                s_char = s_iter.next();
            } else {
                return false;
            }
        }

        sub_iter.next().is_none()
    }
}