use std::collections::{VecDeque};

impl Solution {
    pub fn network_idle_time(n: i32, edges: Vec<Vec<i32>>, initial_data: Vec<i32>) -> i32 {
        let n_usize = n as usize;
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n_usize];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut dist: Vec<i32> = vec![-1; n_usize];
        let mut queue: VecDeque<usize> = VecDeque::new();

        dist[0] = 0;
        queue.push_back(0);

        while let Some(u) = queue.pop_front() {
            for &v in &adj[u] {
                if dist[v] == -1 {
                    dist[v] = dist[u] + 1;
                    queue.push_back(v);
                }
            }
        }

        let mut max_idle_time: i32 = 0;

        for i in 1..n_usize {
            let dist_i = dist[i];
            let initial_data_i = initial_data[i];

            let round_trip_time = 2 * dist_i;

            let mut last_send_time: i32 = 0;
            if initial_data_i < round_trip_time {
                let num_additional_sends = (round_trip_time - 1) / initial_data_i;
                last_send_time = num_additional_sends * initial_data_i;
            }

            let current_server_last_package_return_time = last_send_time + round_trip_time;

            max_idle_time = max_idle_time.max(current_server_last_package_return_time);
        }

        max_idle_time + 1
    }
}