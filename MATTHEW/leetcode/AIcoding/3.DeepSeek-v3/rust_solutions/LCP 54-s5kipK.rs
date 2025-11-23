use std::collections::VecDeque;

impl Solution {
    pub fn minimum_time(n: i32, edges: Vec<Vec<i32>>, disappear: Vec<i32>) -> Vec<i32> {
        let n = n as usize;
        let mut adj = vec![vec![]; n];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            let t = edge[2];
            adj[u].push((v, t));
            adj[v].push((u, t));
        }

        let mut dist = vec![-1; n];
        let mut q = VecDeque::new();
        q.push_back(0);
        dist[0] = 0;

        while let Some(u) = q.pop_front() {
            for &(v, t) in &adj[u] {
                let new_dist = dist[u] + t;
                if new_dist < disappear[v] && (dist[v] == -1 || new_dist < dist[v]) {
                    dist[v] = new_dist;
                    q.push_back(v);
                }
            }
        }

        dist
    }
}