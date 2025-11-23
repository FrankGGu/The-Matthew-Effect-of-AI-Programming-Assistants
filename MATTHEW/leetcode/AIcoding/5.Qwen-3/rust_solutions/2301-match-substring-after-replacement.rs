impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn match_substring_after_replacement(s: String, sub: String, mappings: Vec<Vec<char>>) -> bool {
        let mut map = HashSet::new();
        for pair in mappings {
            map.insert((pair[0], pair[1]));
        }

        let s_chars: Vec<char> = s.chars().collect();
        let sub_chars: Vec<char> = sub.chars().collect();

        let n = s.len();
        let m = sub.len();

        for i in 0..=n - m {
            let mut valid = true;
            for j in 0..m {
                let s_char = s_chars[i + j];
                let sub_char = sub_chars[j];
                if s_char != sub_char && !map.contains(&(s_char, sub_char)) {
                    valid = false;
                    break;
                }
            }
            if valid {
                return true;
            }
        }

        false
    }
}
}