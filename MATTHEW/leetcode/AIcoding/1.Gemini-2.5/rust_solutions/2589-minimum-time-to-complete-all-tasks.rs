impl Solution {
    pub fn min_processing_time(tasks: Vec<Vec<i32>>) -> i32 {
        let mut tasks = tasks;

        // Sort tasks by their end time in ascending order.
        // If end times are equal, sort by start time in ascending order.
        // This greedy strategy processes tasks with earlier deadlines first.
        tasks.sort_unstable_by(|a, b| {
            if a[1] != b[1] {
                a[1].cmp(&b[1])
            } else {
                a[0].cmp(&b[0])
            }
        });

        // `cpu_run[i]` will be true if the CPU is active at time `i`.
        // The maximum possible end time is 2000, so we need an array that can
        // store up to index 2000. `vec![false; 2001]` covers indices 0 through 2000.
        let mut cpu_run = vec![false; 2001];
        let mut total_time_units = 0;

        for task in tasks {
            let start = task[0] as usize;
            let end = task[1] as usize;
            let duration = task[2] as i32;

            // Count how many time units within the task's interval [start, end]
            // are already marked as running by previous tasks.
            let mut already_running_count = 0;
            for t in start..=end {
                if cpu_run[t] {
                    already_running_count += 1;
                }
            }

            // Calculate how many more time units are needed for this task.
            let mut needed_time_units = duration - already_running_count;

            // If additional time units are needed, greedily pick them.
            // It's optimal to pick the latest available time units within the interval [start, end].
            // This leaves earlier time slots free for other tasks that might have earlier deadlines.
            if needed_time_units > 0 {
                // Iterate backwards from `end` down to `start`.
                for t in (start..=end).rev() {
                    if needed_time_units == 0 {
                        break; // All required time units have been assigned.
                    }
                    if !cpu_run[t] {
                        // If this time unit is not yet running, mark it as running.
                        cpu_run[t] = true;
                        total_time_units += 1;
                        needed_time_units -= 1;
                    }
                }
            }
        }

        total_time_units
    }
}