use std::collections::VecDeque;

impl Solution {
    pub fn longest_special_path(n: i32, edges: Vec<Vec<i32>>, cost: Vec<i32>) -> i32 {
        let n = n as usize;
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n];
        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut max_len = -1;
        for start_node in 0..n {
            let mut q: VecDeque<(usize, i32, i32)> = VecDeque::new();
            q.push_back((start_node, cost[start_node], 1));
            let mut visited: Vec<bool> = vec![false; n];
            visited[start_node] = true;

            while let Some((u, sum, len)) = q.pop_front() {
                if sum % cost[u] == 0 && len > 1 {
                    max_len = max_len.max(len);
                }

                for &v in &adj[u] {
                    if !visited[v] && cost[v] <= cost[start_node] {
                        visited[v] = true;
                        q.push_back((v, sum + cost[v], len + 1));
                    }
                }
            }
        }

        max_len
    }
}