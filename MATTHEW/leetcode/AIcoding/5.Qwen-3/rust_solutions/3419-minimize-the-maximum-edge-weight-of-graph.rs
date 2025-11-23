impl Solution {

use std::cmp::Reverse;
use std::collections::{BinaryHeap, HashSet};

impl Solution {
    pub fn minimum_weight(n: i32, edges: Vec<Vec<i32>>, price: i32) -> i32 {
        let n = n as usize;
        let mut graph = vec![vec![]; n];
        for e in edges {
            let u = e[0] as usize;
            let v = e[1] as usize;
            let w = e[2];
            graph[u].push((v, w));
            graph[v].push((u, w));
        }

        let mut dist = vec![i32::MAX; n];
        let mut pq = BinaryHeap::new();
        pq.push(Reverse((0, 0)));
        dist[0] = 0;

        while let Some(Reverse((d, u))) = pq.pop() {
            if u == n - 1 {
                break;
            }
            if d > dist[u] {
                continue;
            }
            for &(v, w) in &graph[u] {
                if dist[v] > d + w {
                    dist[v] = d + w;
                    pq.push(Reverse((dist[v], v)));
                }
            }
        }

        let mut visited = HashSet::new();
        let mut result = 0;
        let mut stack = vec![(n - 1, 0)];
        visited.insert(n - 1);

        while let Some((u, cost)) = stack.pop() {
            result = result.max(cost);
            for &(v, w) in &graph[u] {
                if !visited.contains(&v) && dist[v] + w == dist[u] {
                    visited.insert(v);
                    stack.push((v, cost + w));
                }
            }
        }

        result
    }
}
}