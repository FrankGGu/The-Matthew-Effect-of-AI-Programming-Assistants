use std::collections::HashMap;

impl Solution {
    pub fn frequency_sort(s: String) -> String {
        let mut counts: HashMap<char, i32> = HashMap::new();
        for c in s.chars() {
            *counts.entry(c).or_insert(0) += 1;
        }

        let mut chars: Vec<char> = counts.keys().cloned().collect();
        chars.sort_by(|a, b| counts[b].cmp(&counts[a]));

        let mut result = String::new();
        for c in chars {
            for _ in 0..counts[&c] {
                result.push(c);
            }
        }

        result
    }
}