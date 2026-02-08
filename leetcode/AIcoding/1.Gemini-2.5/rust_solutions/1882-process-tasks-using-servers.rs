use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn assign_tasks(servers: Vec<i32>, tasks: Vec<i32>) -> Vec<i32> {
        let n = servers.len();
        let m = tasks.len();
        let mut ans = vec![0; m];

        let mut available_servers: BinaryHeap<Reverse<(i32, i32)>> = BinaryHeap::new();
        let mut busy_servers: BinaryHeap<Reverse<(i64, i32, i32)>> = BinaryHeap::new();

        for j in 0..n {
            available_servers.push(Reverse((servers[j], j as i32)));
        }

        let mut current_sim_time: i64 = 0;

        for i in 0..m {
            let task_arrival_time = i as i64;
            let task_duration = tasks[i] as i64;

            current_sim_time = current_sim_time.max(task_arrival_time);

            while let Some(Reverse((free_time, weight, index))) = busy_servers.peek() {
                if *free_time <= current_sim_time {
                    busy_servers.pop();
                    available_servers.push(Reverse((*weight, *index)));
                } else {
                    break;
                }
            }

            if available_servers.is_empty() {
                let Reverse((earliest_free_time, weight, index)) = busy_servers.pop().unwrap();
                current_sim_time = earliest_free_time;
                available_servers.push(Reverse((weight, index)));
                while let Some(Reverse((free_time, weight, index))) = busy_servers.peek() {
                    if *free_time <= current_sim_time {
                        busy_servers.pop();
                        available_servers.push(Reverse((*weight, *index)));
                    } else {
                        break;
                    }
                }
            }

            let Reverse((server_weight, server_index)) = available_servers.pop().unwrap();
            ans[i] = server_index;

            let server_free_time = current_sim_time + task_duration;
            busy_servers.push(Reverse((server_free_time, server_weight, server_index)));
        }

        ans
    }
}