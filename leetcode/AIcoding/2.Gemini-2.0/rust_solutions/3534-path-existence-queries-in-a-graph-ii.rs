use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn path_existence_queries(n: i32, edges: Vec<Vec<i32>>, queries: Vec<Vec<i32>>) -> Vec<i64> {
        let n = n as usize;
        let mut adj: Vec<Vec<(usize, i32)>> = vec![vec![]; n];
        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            let w = edge[2];
            adj[u].push((v, w));
            adj[v].push((u, w));
        }

        let mut ans = Vec::new();
        for query in &queries {
            let start = query[0] as usize;
            let end = query[1] as usize;
            let mut dist: Vec<i64> = vec![i64::MAX; n];
            dist[start] = 0;
            let mut pq: BinaryHeap<(Reverse<i64>, usize)> = BinaryHeap::new();
            pq.push((Reverse(0), start));

            while let Some((Reverse(d), u)) = pq.pop() {
                if d > dist[u] {
                    continue;
                }

                if u == end {
                    break;
                }

                for &(v, w) in &adj[u] {
                    let new_dist = d + w as i64;
                    if new_dist < dist[v] {
                        dist[v] = new_dist;
                        pq.push((Reverse(new_dist), v));
                    }
                }
            }

            if dist[end] == i64::MAX {
                ans.push(-1);
            } else {
                ans.push(dist[end]);
            }
        }

        ans
    }
}