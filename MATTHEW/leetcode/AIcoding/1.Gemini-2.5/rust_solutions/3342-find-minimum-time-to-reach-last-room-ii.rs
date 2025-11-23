use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn find_minimum_time(n: i32, operations: Vec<Vec<i32>>) -> i64 {
        let n_usize = n as usize;

        let mut adj: Vec<Vec<(usize, i64)>> = vec![vec![]; n_usize];
        for op in operations {
            let u = op[0] as usize;
            let v = op[1] as usize;
            let w = op[2] as i64;
            adj[u].push((v, w));
        }

        let mut dist: Vec<i64> = vec![i64::MAX; n_usize];
        dist[0] = 0;

        let mut pq: BinaryHeap<Reverse<(i64, usize)>> = BinaryHeap::new();
        pq.push(Reverse((0, 0)));

        while let Some(Reverse((d, u))) = pq.pop() {
            if d > dist[u] {
                continue;
            }

            for &(v, weight) in &adj[u] {
                if dist[u] != i64::MAX && dist[u] + weight < dist[v] {
                    dist[v] = dist[u] + weight;
                    pq.push(Reverse((dist[v], v)));
                }
            }
        }

        if dist[n_usize - 1] == i64::MAX {
            -1
        } else {
            dist[n_usize - 1]
        }
    }
}