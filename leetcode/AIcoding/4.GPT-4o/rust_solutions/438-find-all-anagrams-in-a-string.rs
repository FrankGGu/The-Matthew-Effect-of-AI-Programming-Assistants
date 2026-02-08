use std::collections::HashMap;

pub fn find_anagrams(s: String, p: String) -> Vec<i32> {
    let p_len = p.len();
    let s_len = s.len();
    let mut result = Vec::new();

    if p_len > s_len {
        return result;
    }

    let mut p_count = HashMap::new();
    let mut s_count = HashMap::new();

    for c in p.chars() {
        *p_count.entry(c).or_insert(0) += 1;
    }

    for c in s.chars().take(p_len) {
        *s_count.entry(c).or_insert(0) += 1;
    }

    if p_count == s_count {
        result.push(0);
    }

    for i in p_len..s_len {
        let start_char = s.chars().nth(i - p_len).unwrap();
        let end_char = s.chars().nth(i).unwrap();

        *s_count.entry(end_char).or_insert(0) += 1;

        let count = s_count.entry(start_char).or_insert(0);
        *count -= 1;
        if *count == 0 {
            s_count.remove(&start_char);
        }

        if p_count == s_count {
            result.push((i - p_len + 1) as i32);
        }
    }

    result
}