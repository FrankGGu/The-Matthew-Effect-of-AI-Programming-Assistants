use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn minimum_weighted_subgraph(
        n: i32,
        edges: Vec<Vec<i32>>,
        src1: i32,
        src2: i32,
        dest: i32,
    ) -> i64 {
        let n = n as usize;
        let mut adj = vec![vec![]; n];
        let mut rev_adj = vec![vec![]; n];

        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            let w = edge[2] as i64;
            adj[u].push((v, w));
            rev_adj[v].push((u, w));
        }

        let dist1 = dijkstra(&adj, src1 as usize, n);
        let dist2 = dijkstra(&adj, src2 as usize, n);
        let dist_dest = dijkstra(&rev_adj, dest as usize, n);

        let mut ans = i64::MAX;

        for i in 0..n {
            if dist1[i] != i64::MAX && dist2[i] != i64::MAX && dist_dest[i] != i64::MAX {
                ans = ans.min(dist1[i] + dist2[i] + dist_dest[i]);
            }
        }

        if ans == i64::MAX {
            -1
        } else {
            ans
        }
    }
}

fn dijkstra(adj: &Vec<Vec<(usize, i64)>>, start: usize, n: usize) -> Vec<i64> {
    let mut dist = vec![i64::MAX; n];
    dist[start] = 0;
    let mut pq = BinaryHeap::new();
    pq.push(Reverse((0, start)));

    while let Some(Reverse((d, u))) = pq.pop() {
        if d > dist[u] {
            continue;
        }

        for &(v, w) in &adj[u] {
            if dist[u] + w < dist[v] {
                dist[v] = dist[u] + w;
                pq.push(Reverse((dist[v], v)));
            }
        }
    }

    dist
}

struct Solution;