use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn roll_call(names: Vec<String>) -> HashMap<String, i32> {
        let mut counts: HashMap<String, i32> = HashMap::new();
        for name in names {
            *counts.entry(name).or_insert(0) += 1;
        }
        counts
    }
}