use std::collections::HashMap;

impl Solution {
    pub fn count_pairs(n: i32, edges: Vec<Vec<i32>>, signal_speed: i32) -> Vec<i32> {
        let n = n as usize;
        let mut adj: Vec<Vec<(usize, i32)>> = vec![Vec::new(); n];
        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            let w = edge[2];
            adj[u].push((v, w));
            adj[v].push((u, w));
        }

        let mut result = vec![0; n];

        for i in 0..n {
            let mut counts: HashMap<i32, i32> = HashMap::new();
            for &(neighbor, weight) in &adj[i] {
                let mut visited = vec![false; n];
                visited[i] = true;
                let count = Self::dfs(neighbor, &adj, &mut visited, signal_speed, weight);
                *counts.entry(count).or_insert(0) += 1;
            }

            let mut total_pairs = 0;
            let keys: Vec<i32> = counts.keys().cloned().collect();
            for j in 0..keys.len() {
                for k in j + 1..keys.len() {
                    total_pairs += counts[&keys[j]] * counts[&keys[k]];
                }
            }

            result[i] = total_pairs;
        }

        result
    }

    fn dfs(
        node: usize,
        adj: &Vec<Vec<(usize, i32)>>,
        visited: &mut Vec<bool>,
        signal_speed: i32,
        mut current_weight: i32,
    ) -> i32 {
        visited[node] = true;
        let mut count = 0;

        if current_weight % signal_speed == 0 {
            count += 1;
        }

        for &(neighbor, weight) in &adj[node] {
            if !visited[neighbor] {
                count += Self::dfs(
                    neighbor,
                    adj,
                    visited,
                    signal_speed,
                    current_weight + weight,
                );
            }
        }

        count
    }
}