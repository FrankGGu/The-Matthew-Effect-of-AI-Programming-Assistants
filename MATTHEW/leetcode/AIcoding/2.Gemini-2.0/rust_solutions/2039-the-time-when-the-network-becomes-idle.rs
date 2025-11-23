use std::collections::VecDeque;

impl Solution {
    pub fn network_becomes_idle(edges: Vec<Vec<i32>>, patience: Vec<i32>) -> i32 {
        let n = patience.len();
        let mut adj = vec![vec![]; n];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut dist = vec![i32::MAX; n];
        dist[0] = 0;
        let mut queue = VecDeque::new();
        queue.push_back(0);

        while let Some(u) = queue.pop_front() {
            for &v in &adj[u] {
                if dist[v] == i32::MAX {
                    dist[v] = dist[u] + 1;
                    queue.push_back(v);
                }
            }
        }

        let mut max_time = 0;
        for i in 1..n {
            let d = dist[i] * 2;
            let p = patience[i];
            let num_msgs = (d - 1) / p;
            let send_time = num_msgs * p;
            max_time = max_time.max(send_time + d);
        }

        max_time + 1
    }
}