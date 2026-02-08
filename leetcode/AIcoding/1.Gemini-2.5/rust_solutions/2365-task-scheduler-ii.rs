use std::collections::HashMap;

impl Solution {
    pub fn task_scheduler_ii(tasks: Vec<i32>, space: i32) -> i64 {
        let mut last_completion_time: HashMap<i32, i64> = HashMap::new();
        let mut current_time: i64 = 0;

        for task in tasks {
            // Increment current_time for the next available slot.
            // This is the slot we *attempt* to schedule the current task in.
            current_time += 1; 

            if let Some(&last_time) = last_completion_time.get(&task) {
                // If this task was previously scheduled, check if we need to wait.
                // The task cannot be scheduled before `last_time + space + 1`.
                // If `current_time` is less than or equal to `last_time + space`,
                // it means `current_time` is within the cooldown period.
                // We must jump `current_time` forward to the earliest possible slot.
                if current_time <= last_time + space as i64 {
                    current_time = last_time + space as i64 + 1;
                }
            }

            // Record the actual time this task is completed.
            last_completion_time.insert(task, current_time);
        }

        current_time
    }
}