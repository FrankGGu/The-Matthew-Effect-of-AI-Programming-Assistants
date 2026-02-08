impl Solution {
    pub fn match_replacement(s: String, sub: String, mappings: Vec<Vec<char>>) -> bool {
        let s_bytes = s.as_bytes();
        let sub_bytes = sub.as_bytes();
        let n = s_bytes.len();
        let m = sub_bytes.len();

        if m > n {
            return false;
        }

        let mut map = std::collections::HashMap::new();
        for mapping in mappings {
            map.entry(mapping[0]).or_insert(std::collections::HashSet::new()).insert(mapping[1]);
        }

        for i in 0..=n - m {
            let mut matched = true;
            for j in 0..m {
                if s_bytes[i + j] == sub_bytes[j] {
                    continue;
                }
                if let Some(allowed) = map.get(&(sub_bytes[j] as char)) {
                    if !allowed.contains(&(s_bytes[i + j] as char)) {
                        matched = false;
                        break;
                    }
                } else {
                    matched = false;
                    break;
                }
            }
            if matched {
                return true;
            }
        }

        false
    }
}