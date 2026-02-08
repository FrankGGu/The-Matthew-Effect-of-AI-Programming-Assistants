use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn min_cost(n: i32, roads: Vec<Vec<i32>>, fuel: i32) -> i64 {
        let n = n as usize;
        let mut adj: Vec<Vec<(usize, i32)>> = vec![vec![]; n + 1];
        for road in &roads {
            let u = road[0] as usize;
            let v = road[1] as usize;
            let w = road[2];
            adj[u].push((v, w));
            adj[v].push((u, w));
        }

        let mut dist: Vec<Vec<i64>> = vec![vec![i64::MAX; fuel as usize + 1]; n + 1];
        dist[1][0] = 0;

        let mut pq: BinaryHeap<(Reverse<i64>, usize, i32)> = BinaryHeap::new();
        pq.push((Reverse(0), 1, 0));

        while let Some((Reverse(d), u, f)) = pq.pop() {
            if d > dist[u][f as usize] {
                continue;
            }

            if f < fuel {
                if dist[u][(f + 1) as usize] > d + u as i64 {
                    dist[u][(f + 1) as usize] = d + u as i64;
                    pq.push((Reverse(dist[u][(f + 1) as usize]), u, f + 1));
                }
            }

            for &(v, w) in &adj[u] {
                if f as i32 >= w {
                    if dist[v][(f as i32 - w) as usize] > d {
                        dist[v][(f as i32 - w) as usize] = d;
                        pq.push((Reverse(dist[v][(f as i32 - w) as usize]), v, f as i32 - w));
                    }
                }
            }
        }

        let mut ans = i64::MAX;
        for i in 0..=fuel as usize {
            ans = ans.min(dist[n][i]);
        }

        if ans == i64::MAX {
            -1
        } else {
            ans
        }
    }
}