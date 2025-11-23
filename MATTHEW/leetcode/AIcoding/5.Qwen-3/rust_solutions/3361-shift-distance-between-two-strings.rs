impl Solution {

use std::cmp;

impl Solution {
    pub fn shift_distance(s: String, t: String) -> i32 {
        let mut result = 0;
        let s_chars: Vec<char> = s.chars().collect();
        let t_chars: Vec<char> = t.chars().collect();

        for i in 0..s.len() {
            let s_char = s_chars[i];
            let t_char = t_chars[i];

            if s_char != t_char {
                let mut shift = 0;
                let mut current = s_char;
                while current != t_char {
                    current = ((current as u8 - b'a') + 1) as char;
                    shift += 1;
                }
                result += shift;
            }
        }

        result
    }
}
}