impl Solution {
    pub fn minimum_processing_time(tasks: Vec<i32>) -> i32 {
        let mut tasks = tasks;
        tasks.sort_unstable();
        tasks.iter().enumerate().fold(0, |acc, (i, &time)| acc + time + i as i32)
    }
}