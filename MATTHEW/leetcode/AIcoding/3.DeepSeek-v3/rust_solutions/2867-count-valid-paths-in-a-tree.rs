use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn count_valid_paths(n: i32, edges: Vec<Vec<i32>>) -> i64 {
        let n = n as usize;
        let mut primes = vec![true; n + 1];
        primes[0] = false;
        primes[1] = false;
        for i in 2..=n {
            if primes[i] {
                for j in (i * i..=n).step_by(i) {
                    primes[j] = false;
                }
            }
        }

        let mut adj = vec![vec![]; n + 1];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut res = 0;
        let mut count = vec![0; n + 1];

        fn dfs(
            u: usize,
            parent: usize,
            adj: &Vec<Vec<usize>>,
            primes: &Vec<bool>,
            count: &mut Vec<i64>,
            res: &mut i64,
        ) {
            count[u] = 1;
            for &v in &adj[u] {
                if v == parent {
                    continue;
                }
                dfs(v, u, adj, primes, count, res);
                if primes[u] {
                    *res += count[v];
                } else {
                    count[u] += count[v];
                }
            }
            if primes[u] {
                let mut total = 0;
                let mut sum = 0;
                for &v in &adj[u] {
                    if v == parent {
                        continue;
                    }
                    if !primes[v] {
                        sum += count[v];
                        total += sum * count[v];
                    }
                }
                *res += total;
            }
        }

        dfs(1, 0, &adj, &primes, &mut count, &mut res);
        res
    }
}