use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn min_cost(max_time: i32, edges: Vec<Vec<i32>>, passing_fees: Vec<i32>) -> i32 {
        let n = passing_fees.len();
        let mut adj: Vec<Vec<(usize, i32)>> = vec![vec![]; n];
        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            let time = edge[2];
            adj[u].push((v, time));
            adj[v].push((u, time));
        }

        let mut dist: Vec<i32> = vec![i32::MAX; n];
        let mut time: Vec<i32> = vec![i32::MAX; n];

        let mut pq: BinaryHeap<(Reverse<i32>, i32, usize)> = BinaryHeap::new();
        pq.push((Reverse(passing_fees[0]), 0, 0));
        dist[0] = passing_fees[0];
        time[0] = 0;

        while let Some((Reverse(cost), t, u)) = pq.pop() {
            if cost > dist[u] {
                continue;
            }

            if t > time[u] {
                continue;
            }

            if u == n - 1 {
                continue;
            }

            for &(v, w) in &adj[u] {
                if t + w <= max_time {
                    if dist[v] > cost + passing_fees[v] {
                        dist[v] = cost + passing_fees[v];
                        time[v] = t + w;
                        pq.push((Reverse(dist[v]), time[v], v));
                    } else if t + w < time[v] {
                        time[v] = t + w;
                        pq.push((Reverse(cost + passing_fees[v]), time[v], v));
                    }
                }
            }
        }

        if dist[n - 1] == i32::MAX {
            -1
        } else {
            dist[n - 1]
        }
    }
}