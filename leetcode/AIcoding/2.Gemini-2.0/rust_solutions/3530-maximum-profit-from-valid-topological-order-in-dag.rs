use std::collections::VecDeque;

impl Solution {
    pub fn max_profit(n: i32, edges: Vec<Vec<i32>>, price: Vec<i32>) -> i64 {
        let n = n as usize;
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n];
        let mut indegree: Vec<i32> = vec![0; n];
        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            indegree[v] += 1;
        }

        let mut queue: VecDeque<usize> = VecDeque::new();
        for i in 0..n {
            if indegree[i] == 0 {
                queue.push_back(i);
            }
        }

        let mut dp: Vec<i64> = vec![0; n];
        let mut visited: Vec<bool> = vec![false; n];
        let mut order: Vec<usize> = Vec::new();

        while let Some(u) = queue.pop_front() {
            visited[u] = true;
            order.push(u);

            for &v in &adj[u] {
                indegree[v] -= 1;
                if indegree[v] == 0 {
                    queue.push_back(v);
                }
            }
        }

        if order.len() != n {
            return -1;
        }

        for &u in &order {
            let p = price[u] as i64;
            dp[u] += p;
            for &v in &adj[u] {
                dp[v] = dp[v].max(dp[u]);
            }
        }

        dp[n - 1]
    }
}