use std::collections::{VecDeque, HashSet};

impl Solution {
    pub fn reachable_nodes(n: i32, edges: Vec<Vec<i32>>, restricted: Vec<i32>) -> i32 {
        let mut adj: Vec<Vec<i32>> = vec![vec![]; n as usize];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v as i32);
            adj[v].push(u as i32);
        }

        let restricted_set: HashSet<i32> = restricted.into_iter().collect();

        let mut visited: Vec<bool> = vec![false; n as usize];
        let mut queue: VecDeque<i32> = VecDeque::new();
        let mut reachable_count = 0;

        if restricted_set.contains(&0) {
            return 0;
        }

        queue.push_back(0);
        visited[0 as usize] = true;
        reachable_count += 1;

        while let Some(node) = queue.pop_front() {
            for &neighbor in &adj[node as usize] {
                if !visited[neighbor as usize] && !restricted_set.contains(&neighbor) {
                    visited[neighbor as usize] = true;
                    queue.push_back(neighbor);
                    reachable_count += 1;
                }
            }
        }

        reachable_count
    }
}