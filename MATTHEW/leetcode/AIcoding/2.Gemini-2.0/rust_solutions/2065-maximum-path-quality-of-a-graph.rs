use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn max_path_quality(values: Vec<i32>, edges: Vec<Vec<i32>>, max_time: i32) -> i32 {
        let n = values.len();
        let mut adj: Vec<Vec<(usize, i32)>> = vec![Vec::new(); n];
        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            let time = edge[2];
            adj[u].push((v, time));
            adj[v].push((u, time));
        }

        let mut max_quality = 0;
        let mut visited = vec![0; n];

        fn dfs(
            u: usize,
            current_time: i32,
            current_quality: i32,
            adj: &Vec<Vec<(usize, i32)>>,
            values: &Vec<i32>,
            max_time: i32,
            visited: &mut Vec<i32>,
            max_quality: &mut i32,
        ) {
            if current_time > max_time {
                return;
            }

            if visited[u] == 0 {
                visited[u] += 1;
            } else {
                visited[u] += 1;
            }

            let new_quality = if visited[u] == 1 {
                current_quality + values[u]
            } else {
                current_quality
            };

            if u == 0 {
                *max_quality = (*max_quality).max(new_quality);
            }

            for &(v, time) in &adj[u] {
                dfs(
                    v,
                    current_time + time,
                    new_quality,
                    adj,
                    values,
                    max_time,
                    visited,
                    max_quality,
                );
            }

            visited[u] -= 1;
        }

        let mut visited = vec![0; n];
        dfs(
            0,
            0,
            0,
            &adj,
            &values,
            max_time,
            &mut visited,
            &mut max_quality,
        );

        max_quality
    }
}