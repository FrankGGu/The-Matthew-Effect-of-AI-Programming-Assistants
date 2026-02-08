use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn maximum_points(edges: Vec<Vec<i32>>, coins: Vec<i32>, k: i32) -> i32 {
        let n = coins.len();
        let mut graph = vec![vec![]; n];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            graph[u].push(v);
            graph[v].push(u);
        }

        let mut dp = vec![vec![-1; 14]; n];

        fn dfs(u: usize, parent: usize, graph: &Vec<Vec<usize>>, coins: &Vec<i32>, k: i32, dp: &mut Vec<Vec<i32>>) -> i32 {
            if dp[u][0] != -1 {
                return dp[u][0];
            }

            let mut take_full = 0;
            let mut take_half = 0;

            for &v in &graph[u] {
                if v != parent {
                    take_full += dfs(v, u, graph, coins, k, dp);
                }
            }
            take_full += coins[u] - k;

            if coins[u] >= 1 {
                for &v in &graph[u] {
                    if v != parent {
                        let mut temp_dp = dp.clone();
                        take_half += dfs(v, u, graph, coins, k, &mut temp_dp);
                    }
                }
                take_half += coins[u] / 2;
            }

            dp[u][0] = take_full.max(take_half);
            dp[u][0]
        }

        dfs(0, n, &graph, &coins, k, &mut dp)
    }
}