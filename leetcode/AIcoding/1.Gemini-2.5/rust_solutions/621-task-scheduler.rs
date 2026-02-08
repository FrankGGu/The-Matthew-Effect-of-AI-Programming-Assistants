use std::cmp;

impl Solution {
    pub fn least_interval(tasks: Vec<char>, n: i32) -> i32 {
        let mut counts = [0; 26]; // Frequencies for 'A' through 'Z'
        for &task in &tasks {
            counts[(task as u8 - b'A') as usize] += 1;
        }

        let mut max_freq = 0;
        for &count in &counts {
            if count > max_freq {
                max_freq = count;
            }
        }

        let mut max_freq_count = 0;
        for &count in &counts {
            if count == max_freq {
                max_freq_count += 1;
            }
        }

        let total_tasks = tasks.len() as i32;

        // Calculate the minimum time based on the most frequent tasks and cooldowns.
        // This formula accounts for (max_freq - 1) blocks of (n + 1) length
        // (one task + n cooldowns/other tasks), plus the tasks in the last block.
        let min_time_from_freq = (max_freq - 1) * (n + 1) + max_freq_count;

        // The total time must be at least the total number of tasks.
        // If 'n' is very small, it might be possible to schedule all tasks
        // without any idle time, in which case the total number of tasks
        // is the answer.
        cmp::max(total_tasks, min_time_from_freq)
    }
}