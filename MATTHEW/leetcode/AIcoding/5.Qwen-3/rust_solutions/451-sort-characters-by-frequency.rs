impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn sort_characters_by_frequency(s: String) -> String {
        let mut freq = HashMap::new();
        for c in s.chars() {
            *freq.entry(c).or_insert(0) += 1;
        }

        let mut chars: Vec<(char, usize)> = freq.into_iter().collect();
        chars.sort_by(|a, b| b.1.cmp(&a.1));

        let mut result = String::new();
        for (c, count) in chars {
            result.extend(std::iter::repeat(c).take(count));
        }

        result
    }
}
}