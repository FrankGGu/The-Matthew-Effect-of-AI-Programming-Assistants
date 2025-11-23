use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn reachable_nodes(n: i32, edges: Vec<Vec<i32>>, restricted: Vec<i32>) -> i32 {
        let n = n as usize;
        let mut graph = vec![vec![]; n];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            graph[u].push(v);
            graph[v].push(u);
        }

        let restricted_set: HashSet<i32> = restricted.into_iter().collect();
        let mut visited = vec![false; n];
        let mut queue = VecDeque::new();
        queue.push_back(0);
        visited[0] = true;
        let mut count = 0;

        while let Some(node) = queue.pop_front() {
            if restricted_set.contains(&(node as i32)) {
                continue;
            }
            count += 1;
            for &neighbor in &graph[node] {
                if !visited[neighbor] && !restricted_set.contains(&(neighbor as i32)) {
                    visited[neighbor] = true;
                    queue.push_back(neighbor);
                }
            }
        }

        count
    }
}