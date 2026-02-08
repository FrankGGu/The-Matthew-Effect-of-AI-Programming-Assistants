use std::collections::VecDeque;

impl Solution {
    pub fn min_edge_reversals(n: i32, edges: Vec<Vec<i32>>) -> Vec<i32> {
        let n = n as usize;
        let mut adj = vec![vec![]; n];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push((v, 0));
            adj[v].push((u, 1));
        }

        let mut res = vec![0; n];
        let mut root_rev = 0;
        let mut q = VecDeque::new();
        q.push_back(0);
        let mut visited = vec![false; n];
        visited[0] = true;

        while let Some(u) = q.pop_front() {
            for &(v, cost) in &adj[u] {
                if !visited[v] {
                    visited[v] = true;
                    root_rev += cost;
                    q.push_back(v);
                }
            }
        }

        res[0] = root_rev;
        q.push_back(0);
        let mut visited = vec![false; n];
        visited[0] = true;

        while let Some(u) = q.pop_front() {
            for &(v, cost) in &adj[u] {
                if !visited[v] {
                    visited[v] = true;
                    res[v] = res[u] + if cost == 0 { 1 } else { -1 };
                    q.push_back(v);
                }
            }
        }

        res
    }
}