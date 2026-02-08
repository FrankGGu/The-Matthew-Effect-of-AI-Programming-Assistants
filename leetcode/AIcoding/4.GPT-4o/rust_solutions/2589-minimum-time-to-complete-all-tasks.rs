pub fn min_time_to_complete_tasks(tasks: Vec<i32>, n: i32) -> i32 {
    use std::collections::HashMap;

    let mut task_count = HashMap::new();
    for task in tasks {
        *task_count.entry(task).or_insert(0) += 1;
    }

    let max_freq = task_count.values().cloned().max().unwrap();
    let max_count = task_count.values().filter(|&&x| x == max_freq).count();

    let idle_slots = (max_freq - 1) * n - (task_count.len() - max_count);
    let idle_time = idle_slots.max(0);

    (tasks.len() as i32 + idle_time) as i32
}