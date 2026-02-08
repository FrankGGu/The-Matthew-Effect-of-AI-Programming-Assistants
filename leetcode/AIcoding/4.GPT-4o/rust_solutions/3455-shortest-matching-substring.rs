use std::collections::HashMap;

pub fn min_window(s: String, t: String) -> String {
    let mut t_count = HashMap::new();
    for c in t.chars() {
        *t_count.entry(c).or_insert(0) += 1;
    }

    let mut left = 0;
    let mut right = 0;
    let mut required = t_count.len();
    let mut formed = 0;
    let mut window_counts = HashMap::new();
    let mut min_len = usize::MAX;
    let mut min_window = "".to_string();

    while right < s.len() {
        let c = s.chars().nth(right).unwrap();
        *window_counts.entry(c).or_insert(0) += 1;

        if let Some(&count) = t_count.get(&c) {
            if window_counts[&c] == count {
                formed += 1;
            }
        }

        while left <= right && formed == required {
            let c = s.chars().nth(left).unwrap();
            let end = right - left + 1;
            if end < min_len {
                min_len = end;
                min_window = s[left..=right].to_string();
            }

            *window_counts.get_mut(&c).unwrap() -= 1;
            if let Some(&count) = t_count.get(&c) {
                if window_counts[&c] < count {
                    formed -= 1;
                }
            }
            left += 1;
        }
        right += 1;
    }

    min_window
}