use std::collections::{VecDeque, HashSet};

impl Solution {
    pub fn valid_path(n: i32, edges: Vec<Vec<i32>>, source: i32, destination: i32) -> bool {
        if source == destination {
            return true;
        }

        let mut adj = vec![vec![]; n as usize];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut visited = HashSet::new();
        let mut queue = VecDeque::new();
        queue.push_back(source as usize);
        visited.insert(source as usize);

        while let Some(node) = queue.pop_front() {
            for &neighbor in &adj[node] {
                if neighbor == destination as usize {
                    return true;
                }
                if !visited.contains(&neighbor) {
                    visited.insert(neighbor);
                    queue.push_back(neighbor);
                }
            }
        }

        false
    }
}