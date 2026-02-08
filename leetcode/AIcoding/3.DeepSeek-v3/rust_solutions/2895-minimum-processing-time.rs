impl Solution {
    pub fn min_processing_time(processor_time: Vec<i32>, tasks: Vec<i32>) -> i32 {
        let mut processor_time = processor_time;
        let mut tasks = tasks;
        processor_time.sort();
        tasks.sort_by(|a, b| b.cmp(a));

        let mut max_time = 0;
        for i in 0..processor_time.len() {
            let current_max = processor_time[i] + tasks[i * 4];
            if current_max > max_time {
                max_time = current_max;
            }
        }
        max_time
    }
}