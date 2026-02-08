use std::collections::HashMap;

pub fn min_window(s: String, t: String) -> String {
    let mut t_map = HashMap::new();
    for c in t.chars() {
        *t_map.entry(c).or_insert(0) += 1;
    }

    let mut s_map = HashMap::new();
    let mut left = 0;
    let mut right = 0;
    let mut min_len = std::usize::MAX;
    let mut min_start = 0;
    let mut required = t_map.len();
    let mut formed = 0;

    while right < s.len() {
        let c = s.chars().nth(right).unwrap();
        *s_map.entry(c).or_insert(0) += 1;

        if let Some(&count) = t_map.get(&c) {
            if s_map[&c] == count {
                formed += 1;
            }
        }

        while left <= right && formed == required {
            if right - left + 1 < min_len {
                min_len = right - left + 1;
                min_start = left;
            }
            let l_char = s.chars().nth(left).unwrap();
            s_map.entry(l_char).and_modify(|e| *e -= 1);
            if let Some(&count) = t_map.get(&l_char) {
                if s_map[&l_char] < count {
                    formed -= 1;
                }
            }
            left += 1;
        }
        right += 1;
    }

    if min_len == std::usize::MAX {
        return String::new();
    }

    s[min_start..min_start + min_len].to_string()
}