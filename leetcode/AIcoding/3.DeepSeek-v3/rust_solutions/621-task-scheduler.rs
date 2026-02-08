use std::collections::HashMap;
use std::cmp::max;

impl Solution {
    pub fn least_interval(tasks: Vec<char>, n: i32) -> i32 {
        let mut freq = HashMap::new();
        for &task in &tasks {
            *freq.entry(task).or_insert(0) += 1;
        }

        let max_freq = freq.values().max().unwrap_or(&0);
        let max_count = freq.values().filter(|&&v| v == *max_freq).count() as i32;

        max(tasks.len() as i32, (max_freq - 1) * (n + 1) + max_count)
    }
}