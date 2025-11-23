use std::collections::HashMap;

pub fn least_interval(tasks: Vec<char>, n: i32) -> i32 {
    let mut task_counts = HashMap::new();
    for task in tasks {
        *task_counts.entry(task).or_insert(0) += 1;
    }

    let max_count = *task_counts.values().max().unwrap();
    let max_count_tasks = task_counts.values().filter(|&&count| count == max_count).count();

    let empty_slots = (max_count - 1) * n;
    let available_tasks = tasks.len() as i32 - max_count * max_count_tasks as i32;

    let idle_time = empty_slots - available_tasks;
    let idle_time = if idle_time > 0 { idle_time } else { 0 };

    tasks.len() as i32 + idle_time
}