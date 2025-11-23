impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn min_time_to_complete_tasks(tasks: Vec<Vec<i32>>) -> i32 {
        let mut task_map = HashMap::new();
        for task in &tasks {
            let (start, end, duration) = (task[0], task[1], task[2]);
            task_map.entry(start).or_insert_with(Vec::new).push((end, duration));
        }

        let mut time = 0;
        let mut current_end = -1;

        for (start, tasks) in task_map {
            if start > current_end {
                time += start - current_end;
                current_end = start;
            }

            let mut max_duration = 0;
            for (end, duration) in tasks {
                max_duration = max_duration.max(duration);
                current_end = current_end.max(end);
            }

            time += max_duration;
        }

        time
    }
}
}