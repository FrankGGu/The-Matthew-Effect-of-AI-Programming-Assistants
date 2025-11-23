impl Solution {

use std::collections::{HashMap, PriorityQueue};

struct Solution;

impl Solution {
    pub fn num_restricted_paths(graph: Vec<Vec<i32>>, s: i32, e: i32) -> i32 {
        let n = graph.len();
        let s = s as usize;
        let e = e as usize;

        let mut dist = vec![i32::MAX; n];
        dist[s] = 0;

        let mut pq = PriorityQueue::new();
        pq.push(s, 0);

        while let Some((u, _)) = pq.pop() {
            for &v in &graph[u] {
                let v = v as usize;
                if dist[v] > dist[u] + 1 {
                    dist[v] = dist[u] + 1;
                    pq.push(v, dist[v]);
                }
            }
        }

        let mut nodes: Vec<(i32, usize)> = (0..n as i32).map(|i| (dist[i as usize], i)).collect();
        nodes.sort();

        let mut dp = vec![0; n];
        dp[e] = 1;

        for &(d, u) in nodes.iter().rev() {
            if u == e {
                continue;
            }
            for &v in &graph[u] {
                let v = v as usize;
                if dist[v] < d {
                    dp[u] += dp[v];
                }
            }
        }

        dp[s]
    }
}
}