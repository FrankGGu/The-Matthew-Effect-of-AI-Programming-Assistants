use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn reachable_nodes(n: i32, edges: Vec<Vec<i32>>, restricted: Vec<i32>) -> i32 {
        let mut adj: Vec<Vec<i32>> = vec![vec![]; n as usize];
        for edge in &edges {
            adj[edge[0] as usize].push(edge[1]);
            adj[edge[1] as usize].push(edge[0]);
        }

        let restricted_set: HashSet<i32> = restricted.into_iter().collect();
        let mut visited: Vec<bool> = vec![false; n as usize];
        let mut queue: VecDeque<i32> = VecDeque::new();
        let mut count = 0;

        queue.push_back(0);
        visited[0] = true;

        while let Some(node) = queue.pop_front() {
            if restricted_set.contains(&node) {
                continue;
            }
            count += 1;

            for &neighbor in &adj[node as usize] {
                if !restricted_set.contains(&neighbor) && !visited[neighbor as usize] {
                    visited[neighbor as usize] = true;
                    queue.push_back(neighbor);
                }
            }
        }

        count
    }
}