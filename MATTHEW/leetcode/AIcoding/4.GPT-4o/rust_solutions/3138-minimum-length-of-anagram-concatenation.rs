use std::collections::HashMap;

pub fn min_length_anagram_concat(s: String, t: String) -> i32 {
    let mut s_map = HashMap::new();
    let mut t_map = HashMap::new();

    for c in s.chars() {
        *s_map.entry(c).or_insert(0) += 1;
    }

    for c in t.chars() {
        *t_map.entry(c).or_insert(0) += 1;
    }

    let mut min_length = 0;
    for (key, value) in s_map.iter() {
        if let Some(&t_value) = t_map.get(key) {
            min_length += value.min(&t_value);
        }
    }

    2 * min_length
}