impl Solution {
    pub fn max_min_difference(n: i32, edges: Vec<Vec<i32>>, price: Vec<i32>) -> i32 {
        let n = n as usize;
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n];
        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut dp: Vec<Vec<i32>> = vec![vec![0; 2]; n];
        let mut visited: Vec<bool> = vec![false; n];

        fn dfs(
            u: usize,
            adj: &Vec<Vec<usize>>,
            price: &Vec<i32>,
            dp: &mut Vec<Vec<i32>>,
            visited: &mut Vec<bool>,
        ) {
            visited[u] = true;
            dp[u][0] = price[u];
            dp[u][1] = 0;

            for &v in &adj[u] {
                if !visited[v] {
                    dfs(v, adj, price, dp, visited);
                    dp[u][0] += dp[v][1].max(dp[v][0] - price[v]);
                    dp[u][1] += dp[v][0].max(dp[v][1] - price[v]);
                }
            }
        }

        dfs(0, &adj, &price, &mut dp, &mut visited);
        dp[0][0].max(dp[0][1])
    }
}