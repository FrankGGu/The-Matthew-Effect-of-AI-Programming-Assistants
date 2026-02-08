use std::collections::{HashMap, HashSet, VecDeque};

pub struct Solution;

impl Solution {
    pub fn find_edges(n: i32, edges: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let mut graph = vec![Vec::new(); n as usize + 1];
        for edge in &edges {
            graph[edge[0] as usize].push(edge[1]);
            graph[edge[1] as usize].push(edge[0]);
        }

        let mut dist = vec![i32::MAX; n as usize + 1];
        let mut queue = VecDeque::new();
        dist[1] = 0;
        queue.push_back(1);

        while let Some(node) = queue.pop_front() {
            for &neighbor in &graph[node as usize] {
                if dist[neighbor as usize] > dist[node as usize] + 1 {
                    dist[neighbor as usize] = dist[node as usize] + 1;
                    queue.push_back(neighbor);
                }
            }
        }

        let mut results = vec![];
        for edge in edges {
            if dist[edge[0] as usize] + 1 + dist[edge[1] as usize] == dist[edge[0] as usize] {
                results.push(edge.clone());
            }
        }
        results
    }
}