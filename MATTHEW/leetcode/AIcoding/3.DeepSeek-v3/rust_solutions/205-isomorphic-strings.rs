use std::collections::HashMap;

impl Solution {
    pub fn is_isomorphic(s: String, t: String) -> bool {
        if s.len() != t.len() {
            return false;
        }
        let mut s_to_t = HashMap::new();
        let mut t_to_s = HashMap::new();
        let s_chars: Vec<char> = s.chars().collect();
        let t_chars: Vec<char> = t.chars().collect();

        for i in 0..s_chars.len() {
            let s_char = s_chars[i];
            let t_char = t_chars[i];

            if let Some(&mapped) = s_to_t.get(&s_char) {
                if mapped != t_char {
                    return false;
                }
            } else {
                s_to_t.insert(s_char, t_char);
            }

            if let Some(&mapped) = t_to_s.get(&t_char) {
                if mapped != s_char {
                    return false;
                }
            } else {
                t_to_s.insert(t_char, s_char);
            }
        }
        true
    }
}