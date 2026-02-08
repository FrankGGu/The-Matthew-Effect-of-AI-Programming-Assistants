use std::collections::HashMap;

impl Solution {
    pub fn find_anagrams(s: String, p: String) -> Vec<i32> {
        let s_chars: Vec<char> = s.chars().collect();
        let p_chars: Vec<char> = p.chars().collect();
        let s_len = s_chars.len();
        let p_len = p_chars.len();

        if s_len < p_len {
            return vec![];
        }

        let mut p_count = HashMap::new();
        let mut s_count = HashMap::new();

        for &c in &p_chars {
            *p_count.entry(c).or_insert(0) += 1;
        }

        for &c in &s_chars[..p_len] {
            *s_count.entry(c).or_insert(0) += 1;
        }

        let mut result = Vec::new();
        if s_count == p_count {
            result.push(0);
        }

        for i in p_len..s_len {
            let outgoing = s_chars[i - p_len];
            *s_count.entry(outgoing).or_insert(0) -= 1;
            if s_count[&outgoing] == 0 {
                s_count.remove(&outgoing);
            }

            let incoming = s_chars[i];
            *s_count.entry(incoming).or_insert(0) += 1;

            if s_count == p_count {
                result.push((i - p_len + 1) as i32);
            }
        }

        result
    }
}