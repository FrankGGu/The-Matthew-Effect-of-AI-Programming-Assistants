use std::collections::{BinaryHeap, VecDeque};

pub fn assign_tasks(servers: Vec<i32>, tasks: Vec<i32>) -> Vec<i32> {
    let n = servers.len();
    let mut free_servers: BinaryHeap<(i32, usize)> = BinaryHeap::new();
    let mut busy_servers: BinaryHeap<(i32, usize)> = BinaryHeap::new();
    let mut result = vec![0; tasks.len()];
    let mut time = 0;

    for (i, &server) in servers.iter().enumerate() {
        free_servers.push((server, i));
    }

    let mut task_queue = VecDeque::new();
    for (i, &task) in tasks.iter().enumerate() {
        task_queue.push_back((i, task));
    }

    while let Some((task_idx, task_time)) = task_queue.pop_front() {
        while time < task_time && !busy_servers.is_empty() {
            let (end_time, server_idx) = busy_servers.pop().unwrap();
            time = end_time;
            free_servers.push((servers[server_idx], server_idx));
        }

        if time < task_time {
            time = task_time;
        }

        if let Some((_, server_idx)) = free_servers.pop() {
            result[task_idx] = server_idx as i32;
            busy_servers.push((time + tasks[task_idx], server_idx));
        } else {
            let (end_time, server_idx) = busy_servers.pop().unwrap();
            time = end_time;
            result[task_idx] = server_idx as i32;
            busy_servers.push((time + tasks[task_idx], server_idx));
        }
    }

    result
}