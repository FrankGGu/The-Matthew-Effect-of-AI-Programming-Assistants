use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn assign_tasks(servers: Vec<i32>, tasks: Vec<i32>) -> Vec<i32> {
        let n = servers.len();
        let m = tasks.len();
        let mut ans = vec![0; m];

        let mut available_servers: BinaryHeap<Reverse<(i32, i32)>> = BinaryHeap::new();
        for i in 0..n {
            available_servers.push(Reverse((servers[i], i as i32)));
        }

        let mut busy_servers: BinaryHeap<Reverse<(i64, i32, i32)>> = BinaryHeap::new();

        let mut current_time: i64 = 0;

        for task_idx in 0..m {
            current_time = current_time.max(task_idx as i64);

            while let Some(&Reverse((free_time, weight, server_idx))) = busy_servers.peek() {
                if free_time <= current_time {
                    busy_servers.pop();
                    available_servers.push(Reverse((weight, server_idx)));
                } else {
                    break;
                }
            }

            if available_servers.is_empty() {
                if let Some(Reverse((free_time, weight, server_idx))) = busy_servers.pop() {
                    current_time = free_time;
                    available_servers.push(Reverse((weight, server_idx)));
                }
            }

            if let Some(Reverse((weight, server_idx))) = available_servers.pop() {
                ans[task_idx] = server_idx;
                let task_duration = tasks[task_idx] as i64;
                let server_free_time = current_time + task_duration;
                busy_servers.push(Reverse((server_free_time, weight, server_idx)));
            }
        }

        ans
    }
}