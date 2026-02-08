pub fn smallest_substring(s: String) -> String {
    use std::collections::HashMap;

    let mut last_seen = HashMap::new();
    let mut start = 0;
    let mut min_len = usize::MAX;
    let mut result = String::new();

    for (i, c) in s.chars().enumerate() {
        if let Some(&j) = last_seen.get(&c) {
            if j >= start {
                start = j + 1;
            }
        }
        last_seen.insert(c, i);
        let len = i - start + 1;
        if len < min_len {
            min_len = len;
            result = s[start..=i].to_string();
        }
    }

    result
}