use std::collections::VecDeque;

impl Solution {
    pub fn find_shortest_cycle(n: i32, edges: Vec<Vec<i32>>) -> i32 {
        let n = n as usize;
        let mut adj = vec![vec![]; n];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut min_cycle = i32::MAX;

        for i in 0..n {
            let mut dist = vec![-1; n];
            let mut parent = vec![-1; n];
            let mut q = VecDeque::new();
            q.push_back(i);
            dist[i] = 0;

            while let Some(u) = q.pop_front() {
                for &v in &adj[u] {
                    if dist[v] == -1 {
                        dist[v] = dist[u] + 1;
                        parent[v] = u as i32;
                        q.push_back(v);
                    } else if parent[u] != v as i32 && parent[v] != u as i32 {
                        min_cycle = min_cycle.min(dist[u] + dist[v] + 1);
                    }
                }
            }
        }

        if min_cycle == i32::MAX {
            -1
        } else {
            min_cycle
        }
    }
}