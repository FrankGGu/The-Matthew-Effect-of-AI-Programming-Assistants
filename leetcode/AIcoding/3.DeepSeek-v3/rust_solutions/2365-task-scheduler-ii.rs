use std::collections::HashMap;

impl Solution {
    pub fn task_scheduler_ii(tasks: Vec<i32>, space: i32) -> i64 {
        let mut last_day = HashMap::new();
        let mut current_day = 0i64;
        for task in tasks {
            current_day += 1;
            if let Some(&prev_day) = last_day.get(&task) {
                let required_day = prev_day + space as i64 + 1;
                if current_day < required_day {
                    current_day = required_day;
                }
            }
            last_day.insert(task, current_day);
        }
        current_day
    }
}