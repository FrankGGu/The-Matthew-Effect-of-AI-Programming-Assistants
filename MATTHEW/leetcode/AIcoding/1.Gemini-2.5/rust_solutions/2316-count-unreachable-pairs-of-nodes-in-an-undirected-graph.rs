use std::collections::VecDeque;

impl Solution {
    pub fn count_pairs(n: i32, edges: Vec<Vec<i32>>) -> i64 {
        let n_usize = n as usize;
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n_usize];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut visited: Vec<bool> = vec![false; n_usize];
        let mut component_sizes: Vec<i64> = Vec::new();

        for i in 0..n_usize {
            if !visited[i] {
                let mut current_component_size: i64 = 0;
                let mut q: VecDeque<usize> = VecDeque::new();
                q.push_back(i);
                visited[i] = true;
                current_component_size += 1;

                while let Some(node) = q.pop_front() {
                    for &neighbor in &adj[node] {
                        if !visited[neighbor] {
                            visited[neighbor] = true;
                            current_component_size += 1;
                            q.push_back(neighbor);
                        }
                    }
                }
                component_sizes.push(current_component_size);
            }
        }

        let mut unreachable_pairs: i64 = 0;
        let mut remaining_nodes: i64 = n as i64;

        for &size in &component_sizes {
            unreachable_pairs += size * (remaining_nodes - size);
            remaining_nodes -= size;
        }

        unreachable_pairs
    }
}