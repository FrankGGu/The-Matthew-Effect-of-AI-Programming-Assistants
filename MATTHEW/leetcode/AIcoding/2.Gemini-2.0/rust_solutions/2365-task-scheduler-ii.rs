impl Solution {
    pub fn task_scheduler_ii(tasks: Vec<i32>, space: i32) -> i64 {
        let mut last_executed: std::collections::HashMap<i32, i64> = std::collections::HashMap::new();
        let mut current_day: i64 = 0;
        for task in tasks {
            if let Some(&last_day) = last_executed.get(&task) {
                let next_available_day = last_day + space as i64 + 1;
                current_day = std::cmp::max(current_day, next_available_day);
            }
            last_executed.insert(task, current_day);
            current_day += 1;
        }
        current_day
    }
}