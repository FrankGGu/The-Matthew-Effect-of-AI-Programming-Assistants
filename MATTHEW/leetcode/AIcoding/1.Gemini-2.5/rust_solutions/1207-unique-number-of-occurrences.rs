use std::collections::HashMap;
use std::collections::HashSet;

impl Solution {
    pub fn unique_occurrences(arr: Vec<i32>) -> bool {
        let mut counts: HashMap<i32, i32> = HashMap::new();
        for &num in arr.iter() {
            *counts.entry(num).or_insert(0) += 1;
        }

        let mut unique_counts: HashSet<i32> = HashSet::new();
        for &count in counts.values() {
            if !unique_counts.insert(count) {
                return false;
            }
        }
        true
    }
}