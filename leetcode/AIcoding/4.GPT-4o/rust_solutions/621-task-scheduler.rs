use std::collections::HashMap;

impl Solution {
    pub fn least_interval(tasks: Vec<char>, n: i32) -> i32 {
        let mut count = HashMap::new();
        for &task in &tasks {
            *count.entry(task).or_insert(0) += 1;
        }

        let max_count = count.values().cloned().max().unwrap();
        let max_count_tasks = count.values().filter(|&&c| c == max_count).count() as i32;

        let intervals = (max_count - 1) * (n + 1) + max_count_tasks;
        intervals.max(tasks.len() as i32)
    }
}