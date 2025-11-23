impl Solution {
    pub fn match_replacement(s: String, sub: String, mappings: Vec<Vec<char>>) -> bool {
        use std::collections::HashMap;
        let s_chars: Vec<char> = s.chars().collect();
        let sub_chars: Vec<char> = sub.chars().collect();
        let mut map: HashMap<char, Vec<char>> = HashMap::new();

        for mapping in mappings {
            let (old, new) = (mapping[0], mapping[1]);
            map.entry(old).or_default().push(new);
        }

        for i in 0..=(s_chars.len() - sub_chars.len()) {
            let mut valid = true;
            for j in 0..sub_chars.len() {
                let s_char = s_chars[i + j];
                let sub_char = sub_chars[j];
                if s_char != sub_char {
                    if let Some(replacements) = map.get(&sub_char) {
                        if !replacements.contains(&s_char) {
                            valid = false;
                            break;
                        }
                    } else {
                        valid = false;
                        break;
                    }
                }
            }
            if valid {
                return true;
            }
        }
        false
    }
}