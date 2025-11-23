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
        let mut window_count = HashMap::new();

        for &c in &p_chars {
            *p_count.entry(c).or_insert(0) += 1;
        }

        for i in 0..p_len {
            *window_count.entry(s_chars[i]).or_insert(0) += 1;
        }

        let mut res = Vec::new();
        if window_count == p_count {
            res.push(0);
        }

        for i in p_len..s_len {
            let outgoing = s_chars[i - p_len];
            *window_count.entry(outgoing).or_insert(0) -= 1;
            if window_count[&outgoing] == 0 {
                window_count.remove(&outgoing);
            }

            let incoming = s_chars[i];
            *window_count.entry(incoming).or_insert(0) += 1;

            if window_count == p_count {
                res.push((i - p_len + 1) as i32);
            }
        }

        res
    }
}