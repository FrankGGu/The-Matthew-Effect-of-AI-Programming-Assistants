impl Solution {

use std::collections::{VecDeque, HashMap};

impl Solution {
    pub fn max_edge_sum(n: i32, edges: Vec<Vec<i32>>, k: i32) -> i32 {
        let n = n as usize;
        let k = k as usize;
        let mut graph = vec![vec![]; n];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            graph[u].push(v);
            graph[v].push(u);
        }

        let mut degree = vec![0; n];
        for i in 0..n {
            degree[i] = graph[i].len() as i32;
        }

        let mut pq = std::collections::BinaryHeap::new();
        for i in 0..n {
            pq.push((degree[i], i));
        }

        let mut visited = vec![false; n];
        let mut result = 0;

        while let Some((d, u)) = pq.pop() {
            if visited[u] {
                continue;
            }
            visited[u] = true;
            result += d;
            for &v in &graph[u] {
                if !visited[v] {
                    pq.push((degree[v], v));
                }
            }
        }

        result
    }
}
}