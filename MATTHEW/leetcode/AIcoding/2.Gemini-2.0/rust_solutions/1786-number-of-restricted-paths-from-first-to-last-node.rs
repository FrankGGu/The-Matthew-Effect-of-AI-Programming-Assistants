use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn count_restricted_paths(n: i32, edges: Vec<Vec<i32>>) -> i32 {
        let n = n as usize;
        let mut adj: Vec<Vec<(usize, i32)>> = vec![Vec::new(); n + 1];
        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            let w = edge[2];
            adj[u].push((v, w));
            adj[v].push((u, w));
        }

        let mut dist: Vec<i32> = vec![i32::MAX; n + 1];
        dist[n] = 0;

        let mut pq: BinaryHeap<(Reverse<i32>, usize)> = BinaryHeap::new();
        pq.push((Reverse(0), n));

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

        let mut dp: Vec<i32> = vec![-1; n + 1];
        dp[n] = 1;

        fn dfs(u: usize, adj: &Vec<Vec<(usize, i32)>>, dist: &Vec<i32>, dp: &mut Vec<i32>) -> i32 {
            if dp[u] != -1 {
                return dp[u];
            }

            let mut count = 0;
            for &(v, _) in &adj[u] {
                if dist[v] < dist[u] {
                    count = (count + dfs(v, adj, dist, dp)) % 1000000007;
                }
            }

            dp[u] = count;
            count
        }

        dfs(1, &adj, &dist, &mut dp)
    }
}