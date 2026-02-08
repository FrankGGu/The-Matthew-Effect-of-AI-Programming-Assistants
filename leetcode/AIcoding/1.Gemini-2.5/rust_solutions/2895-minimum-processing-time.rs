impl Solution {
    pub fn min_processing_time(mut processor_time: Vec<i32>, mut tasks: Vec<i32>) -> i32 {
        processor_time.sort();
        tasks.sort_unstable_by(|a, b| b.cmp(a));

        let mut min_max_completion_time = 0;
        let num_processors = processor_time.len();

        for i in 0..num_processors {
            let current_processor_completion = processor_time[i] + tasks[4 * i];
            min_max_completion_time = min_max_completion_time.max(current_processor_completion);
        }

        min_max_completion_time
    }
}