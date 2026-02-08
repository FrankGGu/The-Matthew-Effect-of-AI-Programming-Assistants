use std::collections::HashMap;

pub fn frequency_sort(s: String) -> String {
    let mut count = HashMap::new();
    for c in s.chars() {
        *count.entry(c).or_insert(0) += 1;
    }

    let mut sorted: Vec<_> = count.into_iter().collect();
    sorted.sort_by(|a, b| b.1.cmp(&a.1));

    let mut result = String::new();
    for (c, freq) in sorted {
        result.push_str(&c.to_string().repeat(freq));
    }

    result
}