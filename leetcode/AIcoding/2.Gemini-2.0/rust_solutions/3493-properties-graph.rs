use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn find_reachable_nodes(n: i32, edges: Vec<Vec<i32>>, restricted: Vec<i32>) -> i32 {
        let n = n as usize;
        let mut graph: Vec<Vec<usize>> = vec![vec![]; n];
        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            graph[u].push(v);
            graph[v].push(u);
        }

        let restricted_set: HashSet<usize> = restricted.iter().map(|&x| x as usize).collect();

        let mut visited: Vec<bool> = vec![false; n];
        let mut count = 0;
        let mut queue: Vec<usize> = Vec::new();

        if restricted_set.contains(&0) {
            return 0;
        }

        queue.push(0);
        visited[0] = true;
        count += 1;

        while let Some(u) = queue.pop() {
            for &v in &graph[u] {
                if !visited[v] && !restricted_set.contains(&v) {
                    visited[v] = true;
                    count += 1;
                    queue.push(v);
                }
            }
        }

        count
    }
}