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
        let mut adj: Vec<Vec<(usize, i64)>> = vec![vec![]; n];
        let mut rev_adj: Vec<Vec<(usize, i64)>> = vec![vec![]; n];

        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            let w = edge[2] as i64;
            adj[u].push((v, w));
            rev_adj[v].push((u, w));
        }

        let dist1 = dijkstra(src1 as usize, &adj, n);
        let dist2 = dijkstra(src2 as usize, &adj, n);
        let dist_dest = dijkstra(dest as usize, &rev_adj, n);

        let mut ans = i64::MAX;
        for i in 0..n {
            if dist1[i] == i64::MAX || dist2[i] == i64::MAX || dist_dest[i] == i64::MAX {
                continue;
            }
            ans = ans.min(dist1[i] + dist2[i] + dist_dest[i]);
        }

        if ans == i64::MAX {
            -1
        } else {
            ans
        }
    }
}

fn dijkstra(start: usize, adj: &Vec<Vec<(usize, i64)>>, n: usize) -> Vec<i64> {
    let mut dist: Vec<i64> = vec![i64::MAX; n];
    dist[start] = 0;
    let mut pq: BinaryHeap<(Reverse<i64>, usize)> = BinaryHeap::new();
    pq.push((Reverse(0), start));

    while let Some((Reverse(d), u)) = pq.pop() {
        if d > dist[u] {
            continue;
        }

        for &(v, w) in &adj[u] {
            if dist[v] > dist[u] + w {
                dist[v] = dist[u] + w;
                pq.push((Reverse(dist[v]), v));
            }
        }
    }

    dist
}