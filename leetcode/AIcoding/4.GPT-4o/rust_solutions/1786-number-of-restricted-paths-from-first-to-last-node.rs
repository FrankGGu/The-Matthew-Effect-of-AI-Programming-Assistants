use std::collections::{BinaryHeap, HashMap};

pub struct Solution;

impl Solution {
    pub fn count_restricted_paths(n: i32, edges: Vec<Vec<i32>>) -> i32 {
        let mut graph = vec![vec![]; n as usize + 1];
        for edge in edges {
            graph[edge[0] as usize].push((edge[1], edge[2]));
            graph[edge[1] as usize].push((edge[0], edge[2]));
        }

        let mut dist = vec![i32::MAX; (n + 1) as usize];
        dist[n as usize] = 0;
        let mut pq = BinaryHeap::new();
        pq.push((0, n));

        while let Some((d, node)) = pq.pop() {
            let d = -d;
            if d > dist[node as usize] {
                continue;
            }
            for &(neighbor, weight) in &graph[node as usize] {
                if dist[neighbor as usize] > d + weight {
                    dist[neighbor as usize] = d + weight;
                    pq.push((-dist[neighbor as usize], neighbor));
                }
            }
        }

        let mut dp = vec![0; (n + 1) as usize];
        dp[1] = 1;

        let mut edges = vec![vec![]; (n + 1) as usize];
        for edge in edges {
            edges[edge[0] as usize].push((edge[1], edge[2]));
            edges[edge[1] as usize].push((edge[0], edge[2]));
        }

        let mut stack = vec![1];
        let mut visited = vec![false; (n + 1) as usize];
        while let Some(node) = stack.pop() {
            visited[node as usize] = true;
            for &(neighbor, _) in &edges[node as usize] {
                if !visited[neighbor as usize] && dist[neighbor as usize] > dist[node as usize] {
                    stack.push(neighbor);
                }
            }
        }

        let mut count = 0;
        for i in (1..=n).rev() {
            for &(neighbor, _) in &edges[i as usize] {
                if dist[neighbor as usize] > dist[i as usize] {
                    dp[i as usize] = (dp[i as usize] + dp[neighbor as usize]) % 1_000_000_007;
                }
            }
        }

        dp[1]
    }
}