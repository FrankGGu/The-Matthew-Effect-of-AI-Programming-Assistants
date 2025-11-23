use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn max_weighted_k_edge_path(n: i32, edges: Vec<Vec<i32>>, k: i32) -> i64 {
        let n = n as usize;
        let k = k as usize;

        let mut adj: Vec<Vec<(usize, i64)>> = vec![vec![]; n];
        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            let w = edge[2] as i64;
            adj[u].push((v, w));
        }

        let mut dist: Vec<Vec<i64>> = vec![vec![i64::MIN; k + 1]; n];
        dist[0][0] = 0;

        let mut pq: BinaryHeap<(i64, usize, usize)> = BinaryHeap::new();
        pq.push((0, 0, 0));

        while let Some((Reverse(d), u, edges_taken)) = pq.pop() {
            if d > dist[u][edges_taken] {
                continue;
            }

            if edges_taken == k {
                continue;
            }

            for &(v, w) in &adj[u] {
                let new_dist = d + w;
                if new_dist > dist[v][edges_taken + 1] {
                    dist[v][edges_taken + 1] = new_dist;
                    pq.push((Reverse(new_dist), v, edges_taken + 1));
                }
            }
        }

        let mut max_path = i64::MIN;
        for i in 0..=k {
            max_path = max_path.max(dist[n - 1][i]);
        }

        if max_path == i64::MIN {
            -1
        } else {
            max_path
        }
    }
}

struct Solution;