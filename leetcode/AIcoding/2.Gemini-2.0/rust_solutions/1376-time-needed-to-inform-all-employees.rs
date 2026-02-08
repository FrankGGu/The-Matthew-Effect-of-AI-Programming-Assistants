use std::collections::VecDeque;

impl Solution {
    pub fn num_of_minutes(n: i32, head_id: i32, manager: Vec<i32>, inform_time: Vec<i32>) -> i32 {
        let mut adj: Vec<Vec<i32>> = vec![vec![]; n as usize];
        for i in 0..n {
            if manager[i as usize] != -1 {
                adj[manager[i as usize] as usize].push(i);
            }
        }

        let mut q: VecDeque<(i32, i32)> = VecDeque::new();
        q.push_back((head_id, 0));
        let mut max_time = 0;

        while !q.is_empty() {
            let (u, time) = q.pop_front().unwrap();
            max_time = max_time.max(time);

            for &v in &adj[u as usize] {
                q.push_back((v, time + inform_time[u as usize]));
            }
        }

        max_time
    }
}