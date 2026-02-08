use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn min_score(n: i32, roads: Vec<Vec<i32>>) -> i32 {
        let n = n as usize;
        let mut adj = vec![vec![]; n + 1];
        for road in roads {
            let (a, b, dist) = (road[0] as usize, road[1] as usize, road[2]);
            adj[a].push((b, dist));
            adj[b].push((a, dist));
        }

        let mut visited = HashSet::new();
        let mut queue = VecDeque::new();
        queue.push_back(1);
        visited.insert(1);
        let mut min_dist = i32::MAX;

        while let Some(node) = queue.pop_front() {
            for &(neighbor, dist) in &adj[node] {
                min_dist = min_dist.min(dist);
                if !visited.contains(&neighbor) {
                    visited.insert(neighbor);
                    queue.push_back(neighbor);
                }
            }
        }

        min_dist
    }
}