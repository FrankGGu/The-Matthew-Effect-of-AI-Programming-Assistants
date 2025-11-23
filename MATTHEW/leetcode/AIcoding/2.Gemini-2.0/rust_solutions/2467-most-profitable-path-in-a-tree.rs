use std::collections::VecDeque;

impl Solution {
    pub fn most_profitable_path(edges: Vec<Vec<i32>>, bob: i32, amount: Vec<i32>) -> i32 {
        let n = amount.len();
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n];
        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut bob_dist = vec![-1; n];
        let mut q = VecDeque::new();
        q.push_back((bob as usize, 0));
        bob_dist[bob as usize] = 0;

        while !q.is_empty() {
            let (u, d) = q.pop_front().unwrap();
            for &v in &adj[u] {
                if bob_dist[v] == -1 {
                    bob_dist[v] = d + 1;
                    q.push_back((v, d + 1));
                }
            }
        }

        let mut alice_profit = vec![0; n];
        let mut q = VecDeque::new();
        q.push_back((0, 0));
        let mut visited = vec![false; n];
        visited[0] = true;
        alice_profit[0] = amount[0];

        while !q.is_empty() {
            let (u, d) = q.pop_front().unwrap();
            if d < bob_dist[u] {
                alice_profit[u] = amount[u];
            } else if d == bob_dist[u] {
                alice_profit[u] = amount[u] / 2;
            } else {
                alice_profit[u] = 0;
            }

            for &v in &adj[u] {
                if !visited[v] {
                    visited[v] = true;
                    q.push_back((v, d + 1));
                }
            }
        }

        let mut max_profit = i32::MIN;
        let mut q = VecDeque::new();
        q.push_back((0, 0));
        let mut visited = vec![false; n];
        visited[0] = true;

        while !q.is_empty() {
            let (u, profit) = q.pop_front().unwrap();
            let mut is_leaf = true;
            for &v in &adj[u] {
                if !visited[v] {
                    is_leaf = false;
                    visited[v] = true;
                    q.push_back((v, profit + alice_profit[v] ));
                }
            }

            if is_leaf {
                max_profit = max_profit.max(profit + alice_profit[u]);
            }
        }

        max_profit
    }
}