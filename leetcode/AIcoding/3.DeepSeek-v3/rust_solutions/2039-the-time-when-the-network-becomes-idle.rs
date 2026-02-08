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

        let mut dist = vec![-1; n];
        let mut q = VecDeque::new();
        q.push_back(0);
        dist[0] = 0;

        while let Some(u) = q.pop_front() {
            for &v in &adj[u] {
                if dist[v] == -1 {
                    dist[v] = dist[u] + 1;
                    q.push_back(v);
                }
            }
        }

        let mut res = 0;
        for i in 1..n {
            let d = dist[i] * 2;
            let p = patience[i];
            let last_sent = if d % p == 0 { d - p } else { d - (d % p) };
            let total_time = last_sent + d;
            res = res.max(total_time);
        }
        res + 1
    }
}