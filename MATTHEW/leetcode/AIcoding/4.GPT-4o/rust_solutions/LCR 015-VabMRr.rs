use std::collections::HashMap;

pub fn find_anagrams(s: String, p: String) -> Vec<i32> {
    let s_len = s.len();
    let p_len = p.len();
    let mut result = Vec::new();

    if s_len < p_len {
        return result;
    }

    let mut p_count = vec![0; 26];
    let mut s_count = vec![0; 26];

    for c in p.chars() {
        p_count[(c as usize - 'a' as usize)] += 1;
    }

    for c in s.chars().take(p_len) {
        s_count[(c as usize - 'a' as usize)] += 1;
    }

    if s_count == p_count {
        result.push(0);
    }

    for i in p_len..s_len {
        s_count[(s.chars().nth(i - p_len).unwrap() as usize - 'a' as usize)] -= 1;
        s_count[(s.chars().nth(i).unwrap() as usize - 'a' as usize)] += 1;

        if s_count == p_count {
            result.push((i - p_len + 1) as i32);
        }
    }

    result
}