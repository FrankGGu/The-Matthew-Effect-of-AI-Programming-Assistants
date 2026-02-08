use std::collections::VecDeque;

impl Solution {
    pub fn find_edges(n: i32, edges: Vec<Vec<i32>>, src: i32, dst: i32) -> Vec<i32> {
        let n = n as usize;
        let src = src as usize;
        let dst = dst as usize;

        let mut adj = vec![vec![]; n];
        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut dist = vec![usize::MAX; n];
        let mut parents = vec![vec![]; n];
        let mut q = VecDeque::new();

        dist[src] = 0;
        q.push_back(src);

        while let Some(u) = q.pop_front() {
            for &v in &adj[u] {
                if dist[v] > dist[u] + 1 {
                    dist[v] = dist[u] + 1;
                    parents[v].clear();
                    parents[v].push(u);
                    q.push_back(v);
                } else if dist[v] == dist[u] + 1 {
                    parents[v].push(u);
                }
            }
        }

        let shortest_path_len = dist[dst];

        let mut on_shortest_path = vec![false; edges.len()];

        if shortest_path_len == usize::MAX {
            return on_shortest_path;
        }

        let mut visited = vec![false; n];
        let mut stack = vec![dst];
        visited[dst] = true;

        while let Some(u) = stack.pop() {
            if u == src {
                continue;
            }

            for &parent in &parents[u] {
                for (i, edge) in edges.iter().enumerate() {
                    let u1 = edge[0] as usize;
                    let v1 = edge[1] as usize;

                    if (u1 == u && v1 == parent) || (v1 == u && u1 == parent) {
                        on_shortest_path[i] = true;
                    }
                }

                if !visited[parent] {
                    visited[parent] = true;
                    stack.push(parent);
                }
            }
        }

        on_shortest_path
    }
}