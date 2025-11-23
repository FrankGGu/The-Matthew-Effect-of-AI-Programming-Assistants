use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn minimum_total_price(n: i32, edges: Vec<Vec<i32>>, price: Vec<i32>, trips: Vec<Vec<i32>>) -> i32 {
        let n = n as usize;
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n];
        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut counts: Vec<i32> = vec![0; n];

        for trip in &trips {
            let start = trip[0] as usize;
            let end = trip[1] as usize;

            let mut path: Vec<usize> = Vec::new();
            let mut visited: Vec<bool> = vec![false; n];
            let mut found = false;

            fn dfs(
                u: usize,
                end: usize,
                adj: &Vec<Vec<usize>>,
                visited: &mut Vec<bool>,
                path: &mut Vec<usize>,
                counts: &mut Vec<i32>,
                found: &mut bool,
            ) {
                visited[u] = true;
                path.push(u);

                if u == end {
                    *found = true;
                    for &node in path {
                        counts[node] += 1;
                    }
                } else {
                    for &v in &adj[u] {
                        if !visited[v] {
                            dfs(v, end, adj, visited, path, counts, found);
                        }
                    }
                }

                if !*found {
                    path.pop();
                }
                visited[u] = false;
            }

            dfs(start, end, &adj, &mut visited, &mut path, &mut counts, &mut found);
        }

        let mut dp: Vec<[i32; 2]> = vec![[0; 2]; n];

        fn solve(
            u: usize,
            parent: usize,
            adj: &Vec<Vec<usize>>,
            price: &Vec<i32>,
            counts: &Vec<i32>,
            dp: &mut Vec<[i32; 2]>,
        ) {
            dp[u][0] = price[u] * counts[u];
            dp[u][1] = 0;

            for &v in &adj[u] {
                if v != parent {
                    solve(v, u, adj, price, counts, dp);
                    dp[u][0] += std::cmp::min(dp[v][0], dp[v][1]);
                    dp[u][1] += dp[v][0];
                }
            }
        }

        solve(0, n, &adj, &price, &counts, &mut dp);
        std::cmp::min(dp[0][0], dp[0][1])
    }
}