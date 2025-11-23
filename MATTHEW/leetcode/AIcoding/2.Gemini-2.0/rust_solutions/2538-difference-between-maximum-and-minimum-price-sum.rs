use std::collections::HashMap;

impl Solution {
    pub fn max_profit(n: i32, edges: Vec<Vec<i32>>, price: Vec<i32>) -> i64 {
        let n = n as usize;
        let mut adj: Vec<Vec<usize>> = vec![Vec::new(); n];
        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut dp: Vec<(i64, i64)> = vec![(0, 0); n];
        let mut visited: Vec<bool> = vec![false; n];

        fn dfs(
            u: usize,
            adj: &Vec<Vec<usize>>,
            price: &Vec<i32>,
            dp: &mut Vec<(i64, i64)>,
            visited: &mut Vec<bool>,
        ) {
            visited[u] = true;
            dp[u].0 = price[u] as i64;
            dp[u].1 = 0;

            for &v in &adj[u] {
                if !visited[v] {
                    dfs(v, adj, price, dp, visited);
                    dp[u].0 += dp[v].1.max(dp[v].0);
                    dp[u].1 += dp[v].1.max(dp[v].0);
                }
            }

            dp[u].1 -= price[u] as i64;
        }

        dfs(0, &adj, &price, &mut dp, &mut visited);
        dp[0].0.max(dp[0].1)
    }
}