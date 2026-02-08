use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn unique_occurrences(arr: Vec<i32>) -> bool {
        let mut frequency = HashMap::new();
        for &num in &arr {
            *frequency.entry(num).or_insert(0) += 1;
        }
        let mut occurrences = HashSet::new();
        for &count in frequency.values() {
            if !occurrences.insert(count) {
                return false;
            }
        }
        true
    }
}