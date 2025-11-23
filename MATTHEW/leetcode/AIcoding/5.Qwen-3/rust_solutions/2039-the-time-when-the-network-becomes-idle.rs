impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn max_time_to_idle(n: i32, edges: Vec<Vec<i32>>, patience: Vec<i32>, k: i32) -> i32 {
        let n = n as usize;
        let mut graph = vec![Vec::new(); n];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            graph[u].push(v);
            graph[v].push(u);
        }

        let mut visited = vec![false; n];
        let mut queue = VecDeque::new();
        queue.push_back((0, 0));
        visited[0] = true;

        let mut max_time = 0;

        while let Some((node, depth)) = queue.pop_front() {
            let mut time = 0;
            if depth == 0 {
                time = 0;
            } else {
                let cycle = 2 * depth;
                let full_cycles = (patience[node] as f64 / cycle as f64).floor() as i32;
                let remainder = (patience[node] as i32 % cycle);
                if remainder == 0 {
                    time = full_cycles * cycle;
                } else {
                    time = (full_cycles + 1) * cycle;
                }
            }
            max_time = max_time.max(time);

            for &neighbor in &graph[node] {
                if !visited[neighbor] {
                    visited[neighbor] = true;
                    queue.push_back((neighbor, depth + 1));
                }
            }
        }

        max_time
    }
}
}