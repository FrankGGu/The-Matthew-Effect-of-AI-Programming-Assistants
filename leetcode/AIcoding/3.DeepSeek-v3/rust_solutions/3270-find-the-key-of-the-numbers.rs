use std::collections::HashMap;

impl Solution {
    pub fn find_key(numbers: Vec<i32>) -> i32 {
        let mut freq = HashMap::new();
        for &num in &numbers {
            *freq.entry(num).or_insert(0) += 1;
        }
        let max_freq = freq.values().max().unwrap_or(&0);
        let candidates: Vec<_> = freq.iter()
            .filter(|&(_, &v)| v == *max_freq)
            .map(|(&k, _)| k)
            .collect();
        *candidates.iter().min().unwrap_or(&0)
    }
}