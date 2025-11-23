use std::collections::{VecDeque, HashSet};

impl Solution {
    pub fn min_reorder(n: i32, connections: Vec<Vec<i32>>) -> i32 {
        let n = n as usize;
        let mut adj: Vec<Vec<(usize, i32)>> = vec![vec![]; n];
        for conn in &connections {
            adj[conn[0] as usize].push((conn[1] as usize, 1));
            adj[conn[1] as usize].push((conn[0] as usize, 0));
        }

        let mut q = VecDeque::new();
        q.push_back(0);
        let mut visited = HashSet::new();
        visited.insert(0);
        let mut reorders = 0;

        while let Some(u) = q.pop_front() {
            for &(v, cost) in &adj[u] {
                if !visited.contains(&v) {
                    reorders += cost;
                    visited.insert(v);
                    q.push_back(v);
                }
            }
        }

        reorders
    }
}