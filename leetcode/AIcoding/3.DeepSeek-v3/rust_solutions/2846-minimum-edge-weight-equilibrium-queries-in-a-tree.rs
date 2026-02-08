use std::collections::{HashMap, VecDeque};

struct Solution;

impl Solution {
    pub fn min_operations_queries(n: i32, edges: Vec<Vec<i32>>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let n = n as usize;
        let mut adj = vec![vec![]; n];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            let w = edge[2] - 1;
            adj[u].push((v, w));
            adj[v].push((u, w));
        }

        let mut parent = vec![vec![0; n]; 20];
        let mut depth = vec![0; n];
        let mut freq = vec![vec![0; 26]; n];
        let mut q = VecDeque::new();
        q.push_back(0);
        parent[0][0] = 0;
        depth[0] = 0;

        while let Some(u) = q.pop_front() {
            for &(v, w) in &adj[u] {
                if v != parent[0][u] {
                    parent[0][v] = u;
                    depth[v] = depth[u] + 1;
                    for i in 0..26 {
                        freq[v][i] = freq[u][i];
                    }
                    freq[v][w as usize] += 1;
                    q.push_back(v);
                }
            }
        }

        for k in 1..20 {
            for v in 0..n {
                parent[k][v] = parent[k - 1][parent[k - 1][v]];
            }
        }

        let mut res = vec![];
        for query in queries {
            let mut u = query[0] as usize;
            let mut v = query[1] as usize;
            if depth[u] < depth[v] {
                std::mem::swap(&mut u, &mut v);
            }

            let mut cnt = vec![0; 26];
            for i in 0..26 {
                cnt[i] += freq[u][i];
                cnt[i] += freq[v][i];
            }

            for k in (0..20).rev() {
                if depth[u] - (1 << k) >= depth[v] {
                    u = parent[k][u];
                }
            }

            if u != v {
                for k in (0..20).rev() {
                    if parent[k][u] != parent[k][v] {
                        u = parent[k][u];
                        v = parent[k][v];
                    }
                }
                u = parent[0][u];
            }

            for i in 0..26 {
                cnt[i] -= 2 * freq[u][i];
            }

            let total: i32 = cnt.iter().sum();
            let max = cnt.iter().max().unwrap();
            res.push(total - max);
        }
        res
    }
}