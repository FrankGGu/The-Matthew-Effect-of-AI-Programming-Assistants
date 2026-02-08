use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn assign_tasks(servers: Vec<i32>, tasks: Vec<i32>) -> Vec<i32> {
        let mut available = BinaryHeap::new();
        for (i, &weight) in servers.iter().enumerate() {
            available.push((Reverse(weight), Reverse(i as i32)));
        }

        let mut busy: BinaryHeap<(i32, i32, i32)> = BinaryHeap::new();
        let mut ans = Vec::new();
        let mut time = 0;

        for i in 0..tasks.len() {
            time = time.max(i as i32);

            while !busy.is_empty() && busy.peek().unwrap().0 <= time {
                let (_, weight, server_idx) = busy.pop().unwrap();
                available.push((Reverse(weight), Reverse(server_idx)));
            }

            if available.is_empty() {
                time = busy.peek().unwrap().0;
                while !busy.is_empty() && busy.peek().unwrap().0 <= time {
                    let (_, weight, server_idx) = busy.pop().unwrap();
                    available.push((Reverse(weight), Reverse(server_idx)));
                }
            }

            let (Reverse(weight), Reverse(server_idx)) = available.pop().unwrap();
            ans.push(server_idx);
            busy.push((time + tasks[i], weight, server_idx));
        }

        ans
    }
}