use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn match_substring_after_replacement(s: String, sub: String, mappings: Vec<Vec<char>>) -> bool {
        let s_chars: Vec<char> = s.chars().collect();
        let sub_chars: Vec<char> = sub.chars().collect();
        let n = s_chars.len();
        let m = sub_chars.len();

        if m == 0 {
            return true;
        }
        if m > n {
            return false;
        }

        let mut replacements: HashMap<char, HashSet<char>> = HashMap::new();
        for mapping in mappings {
            let old_char = mapping[0];
            let new_char = mapping[1];
            replacements.entry(old_char).or_insert_with(HashSet::new).insert(new_char);
        }

        for i in 0..=(n - m) {
            let mut current_match = true;
            for j in 0..m {
                let s_char = s_chars[i + j];
                let sub_char = sub_chars[j];

                if s_char == sub_char {
                    continue;
                } else {
                    if let Some(possible_replacements) = replacements.get(&sub_char) {
                        if possible_replacements.contains(&s_char) {
                            continue;
                        }
                    }
                    current_match = false;
                    break;
                }
            }
            if current_match {
                return true;
            }
        }

        false
    }
}