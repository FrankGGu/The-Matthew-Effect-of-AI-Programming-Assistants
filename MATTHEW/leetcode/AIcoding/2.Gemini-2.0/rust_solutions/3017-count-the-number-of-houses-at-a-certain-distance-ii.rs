use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn count_of_pairs(n: i32, x: i32, y: i32) -> Vec<i64> {
        let n = n as usize;
        let x = x as usize - 1;
        let y = y as usize - 1;
        let mut adj = vec![vec![]; n];
        for i in 0..n - 1 {
            adj[i].push((i + 1, 1));
            adj[i + 1].push((i, 1));
        }
        adj[x].push((y, 1));
        adj[y].push((x, 1));

        let mut ans = vec![0; n];
        for start in 0..n {
            let mut dist = vec![i32::MAX; n];
            dist[start] = 0;
            let mut pq = BinaryHeap::new();
            pq.push(Reverse((0, start)));

            while let Some(Reverse((d, u))) = pq.pop() {
                if d > dist[u] {
                    continue;
                }

                for &(v, w) in &adj[u] {
                    if dist[v] > dist[u] + w {
                        dist[v] = dist[u] + w;
                        pq.push(Reverse((dist[v], v)));
                    }
                }
            }

            for i in 0..n {
                if i != start {
                    ans[dist[i] as usize] += 1;
                }
            }
        }

        ans.iter().map(|&x| x as i64).collect()
    }
}