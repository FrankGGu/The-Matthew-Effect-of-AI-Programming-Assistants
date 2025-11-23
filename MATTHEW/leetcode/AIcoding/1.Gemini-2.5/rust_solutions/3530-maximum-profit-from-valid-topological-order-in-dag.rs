use std::collections::VecDeque;

impl Solution {
    pub fn maximum_profit(n: i32, profits: Vec<i32>, dependencies: Vec<Vec<i32>>) -> i32 {
        let n_usize = n as usize;
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n_usize];
        let mut in_degree: Vec<i32> = vec![0; n_usize];

        for dep in dependencies {
            let u = dep[0] as usize;
            let v = dep[1] as usize;
            adj[u].push(v);
            in_degree[v] += 1;
        }

        let mut dp: Vec<i32> = profits.clone();
        let mut q: VecDeque<usize> = VecDeque::new();

        for i in 0..n_usize {
            if in_degree[i] == 0 {
                q.push_back(i);
            }
        }

        let mut max_overall_profit = 0;
        if n_usize > 0 {
            max_overall_profit = *profits.iter().max().unwrap_or(&0);
        }

        while let Some(u) = q.pop_front() {
            max_overall_profit = max_overall_profit.max(dp[u]);

            for &v in &adj[u] {
                dp[v] = dp[v].max(dp[u] + profits[v]);
                in_degree[v] -= 1;
                if in_degree[v] == 0 {
                    q.push_back(v);
                }
            }
        }

        max_overall_profit
    }
}