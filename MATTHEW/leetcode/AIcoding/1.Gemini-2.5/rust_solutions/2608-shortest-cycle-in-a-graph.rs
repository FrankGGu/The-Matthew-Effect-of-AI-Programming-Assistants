use std::collections::VecDeque;

impl Solution {
    pub fn shortest_cycle(n: i32, edges: Vec<Vec<i32>>) -> i32 {
        let n_usize = n as usize;
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n_usize];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut min_cycle_len = i32::MAX;

        for start_node in 0..n_usize {
            let mut dist: Vec<i32> = vec![i32::MAX; n_usize];
            let mut parent: Vec<i32> = vec![-1; n_usize];
            let mut queue: VecDeque<usize> = VecDeque::new();

            dist[start_node] = 0;
            queue.push_back(start_node);

            while let Some(u) = queue.pop_front() {
                for &v in &adj[u] {
                    if dist[v] == i32::MAX { // v not visited
                        dist[v] = dist[u] + 1;
                        parent[v] = u as i32;
                        queue.push_back(v);
                    } else if v as i32 != parent[u] { // v visited, and not the parent of u (i.e., not the edge that brought us to u)
                        // Found a cycle
                        let cycle_len = dist[u] + dist[v] + 1;
                        min_cycle_len = min_cycle_len.min(cycle_len);
                    }
                }
            }
        }

        if min_cycle_len == i32::MAX {
            -1
        } else {
            min_cycle_len
        }
    }
}