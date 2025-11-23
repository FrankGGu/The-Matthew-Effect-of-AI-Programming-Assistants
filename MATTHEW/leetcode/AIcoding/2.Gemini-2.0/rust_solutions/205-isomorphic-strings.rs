use std::collections::HashMap;

impl Solution {
    pub fn is_isomorphic(s: String, t: String) -> bool {
        let s_bytes = s.as_bytes();
        let t_bytes = t.as_bytes();
        let mut s_to_t: HashMap<u8, u8> = HashMap::new();
        let mut t_to_s: HashMap<u8, u8> = HashMap::new();

        if s_bytes.len() != t_bytes.len() {
            return false;
        }

        for i in 0..s_bytes.len() {
            let s_char = s_bytes[i];
            let t_char = t_bytes[i];

            if s_to_t.contains_key(&s_char) {
                if s_to_t[&s_char] != t_char {
                    return false;
                }
            } else {
                if t_to_s.contains_key(&t_char) {
                    return false;
                }
                s_to_t.insert(s_char, t_char);
                t_to_s.insert(t_char, s_char);
            }
        }

        true
    }
}