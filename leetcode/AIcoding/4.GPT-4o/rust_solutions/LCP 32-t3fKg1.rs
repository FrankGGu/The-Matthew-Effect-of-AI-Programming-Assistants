pub fn process_tasks(tasks: Vec<i32>, n: i32) -> i32 {
    use std::collections::HashMap;

    let mut task_count = HashMap::new();
    for task in tasks {
        *task_count.entry(task).or_insert(0) += 1;
    }

    let max_freq = *task_count.values().max().unwrap();
    let max_count = task_count.values().filter(|&&x| x == max_freq).count();

    let intervals = (max_freq - 1) * (n + 1) + max_count;
    std::cmp::max(intervals, tasks.len() as i32)
}