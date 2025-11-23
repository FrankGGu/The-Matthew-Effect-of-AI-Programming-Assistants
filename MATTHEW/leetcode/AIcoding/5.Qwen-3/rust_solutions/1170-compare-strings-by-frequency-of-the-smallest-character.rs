impl Solution {

use std::collections::HashMap;

struct Solution {}

impl Solution {
    pub fn frequency_sort(mut s: String) -> String {
        let mut freq = HashMap::new();
        for c in s.chars() {
            *freq.entry(c).or_insert(0) += 1;
        }

        let mut chars: Vec<(char, usize)> = freq.into_iter().collect();
        chars.sort_by(|a, b| b.1.cmp(&a.1).then_with(|| a.0.cmp(&b.0)));

        let mut result = String::new();
        for (c, count) in chars {
            result.push_str(&c.to_string().repeat(count));
        }

        result
    }
}
}