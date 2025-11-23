use std::collections::HashMap;

impl Solution {
    pub fn min_steps(s: String, t: String) -> i32 {
        let mut freq = HashMap::new();

        for c in s.chars() {
            *freq.entry(c).or_insert(0) += 1;
        }

        for c in t.chars() {
            *freq.entry(c).or_insert(0) -= 1;
        }

        freq.values().map(|&count| count.abs()).sum()
    }
}