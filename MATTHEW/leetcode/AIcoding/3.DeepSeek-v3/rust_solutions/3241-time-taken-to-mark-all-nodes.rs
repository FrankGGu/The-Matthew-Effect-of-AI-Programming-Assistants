use std::collections::VecDeque;

impl Solution {
    pub fn time_to_mark_all_nodes(n: i32, edges: Vec<Vec<i32>>) -> i32 {
        let n = n as usize;
        let mut adj = vec![vec![]; n];
        let mut in_degree = vec![0; n];

        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            in_degree[v] += 1;
        }

        let mut queue = VecDeque::new();
        let mut time = vec![1; n];

        for i in 0..n {
            if in_degree[i] == 0 {
                queue.push_back(i);
            }
        }

        while let Some(u) = queue.pop_front() {
            for &v in &adj[u] {
                time[v] = time[v].max(time[u] + 1);
                in_degree[v] -= 1;
                if in_degree[v] == 0 {
                    queue.push_back(v);
                }
            }
        }

        *time.iter().max().unwrap_or(&0)
    }
}