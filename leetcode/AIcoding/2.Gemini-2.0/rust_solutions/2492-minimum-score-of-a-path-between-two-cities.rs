use std::collections::VecDeque;

impl Solution {
    pub fn min_score(n: i32, roads: Vec<Vec<i32>>) -> i32 {
        let n = n as usize;
        let mut adj: Vec<Vec<(usize, i32)>> = vec![Vec::new(); n + 1];
        for road in &roads {
            let u = road[0] as usize;
            let v = road[1] as usize;
            let w = road[2];
            adj[u].push((v, w));
            adj[v].push((u, w));
        }

        let mut min_score = i32::MAX;
        let mut visited = vec![false; n + 1];
        let mut queue: VecDeque<usize> = VecDeque::new();
        queue.push_back(1);
        visited[1] = true;

        while let Some(u) = queue.pop_front() {
            for &(v, w) in &adj[u] {
                min_score = min_score.min(w);
                if !visited[v] {
                    visited[v] = true;
                    queue.push_back(v);
                }
            }
        }

        min_score
    }
}