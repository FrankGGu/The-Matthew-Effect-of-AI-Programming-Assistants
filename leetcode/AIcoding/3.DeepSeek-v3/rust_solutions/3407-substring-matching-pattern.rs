use std::collections::HashMap;

impl Solution {
    pub fn is_match(s: String, p: String) -> bool {
        let s_chars: Vec<char> = s.chars().collect();
        let p_chars: Vec<char> = p.chars().collect();

        let mut s_to_p = HashMap::new();
        let mut p_to_s = HashMap::new();

        if s_chars.len() != p_chars.len() {
            return false;
        }

        for i in 0..s_chars.len() {
            let s_char = s_chars[i];
            let p_char = p_chars[i];

            if let Some(&mapped_p) = s_to_p.get(&s_char) {
                if mapped_p != p_char {
                    return false;
                }
            } else {
                s_to_p.insert(s_char, p_char);
            }

            if let Some(&mapped_s) = p_to_s.get(&p_char) {
                if mapped_s != s_char {
                    return false;
                }
            } else {
                p_to_s.insert(p_char, s_char);
            }
        }

        true
    }
}