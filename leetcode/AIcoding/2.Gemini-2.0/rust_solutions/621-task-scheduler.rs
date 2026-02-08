use std::collections::HashMap;

impl Solution {
    pub fn least_interval(tasks: Vec<char>, n: i32) -> i32 {
        let mut counts: HashMap<char, i32> = HashMap::new();
        for &task in &tasks {
            *counts.entry(task).or_insert(0) += 1;
        }

        let mut max_count = 0;
        let mut max_count_tasks = 0;
        for &count in counts.values() {
            if count > max_count {
                max_count = count;
                max_count_tasks = 1;
            } else if count == max_count {
                max_count_tasks += 1;
            }
        }

        let part_count = max_count - 1;
        let part_length = n - (max_count_tasks - 1);
        let empty_slots = part_count * part_length;
        let available_tasks = tasks.len() as i32 - max_count * max_count_tasks;
        let idles = std::cmp::max(0, empty_slots - available_tasks);

        tasks.len() as i32 + idles
    }
}