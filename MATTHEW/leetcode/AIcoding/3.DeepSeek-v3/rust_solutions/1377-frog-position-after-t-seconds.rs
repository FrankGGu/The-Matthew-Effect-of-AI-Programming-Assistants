use std::collections::VecDeque;

impl Solution {
    pub fn frog_position(n: i32, edges: Vec<Vec<i32>>, t: i32, target: i32) -> f64 {
        let n = n as usize;
        let target = target as usize;
        let mut adj = vec![vec![]; n + 1];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut prob = vec![0.0; n + 1];
        let mut visited = vec![false; n + 1];
        let mut q = VecDeque::new();
        q.push_back((1, 0));
        prob[1] = 1.0;
        visited[1] = true;

        while let Some((u, time)) = q.pop_front() {
            if time >= t {
                continue;
            }
            let mut children = 0;
            for &v in &adj[u] {
                if !visited[v] {
                    children += 1;
                }
            }
            if children == 0 {
                continue;
            }
            let p = prob[u] / children as f64;
            for &v in &adj[u] {
                if !visited[v] {
                    visited[v] = true;
                    prob[v] = p;
                    q.push_back((v, time + 1));
                }
            }
            prob[u] = 0.0;
        }

        prob[target]
    }
}