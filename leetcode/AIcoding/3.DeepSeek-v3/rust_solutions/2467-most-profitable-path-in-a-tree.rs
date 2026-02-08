use std::collections::{HashMap, VecDeque};

struct Solution;

impl Solution {
    pub fn most_profitable_path(edges: Vec<Vec<i32>>, bob: i32, amount: Vec<i32>) -> i32 {
        let n = amount.len();
        let mut adj = vec![vec![]; n];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut parent = vec![0; n];
        let mut depth = vec![0; n];
        let mut q = VecDeque::new();
        q.push_back(0);
        parent[0] = n;

        while let Some(u) = q.pop_front() {
            for &v in &adj[u] {
                if parent[v] == 0 && v != parent[u] {
                    parent[v] = u;
                    depth[v] = depth[u] + 1;
                    q.push_back(v);
                }
            }
        }

        let mut bob_path = vec![];
        let mut u = bob as usize;
        while u != n {
            bob_path.push(u);
            u = parent[u];
        }

        let mut bob_time = HashMap::new();
        for (t, &u) in bob_path.iter().enumerate() {
            bob_time.insert(u, t);
        }

        let mut max_profit = i32::MIN;
        let mut q = VecDeque::new();
        q.push_back((0, 0, 0));

        while let Some((u, time, profit)) = q.pop_front() {
            let current_profit = if let Some(&t) = bob_time.get(&u) {
                if time < t {
                    amount[u]
                } else if time == t {
                    amount[u] / 2
                } else {
                    0
                }
            } else {
                amount[u]
            };

            let new_profit = profit + current_profit;

            if adj[u].len() == 1 && u != 0 {
                max_profit = max_profit.max(new_profit);
                continue;
            }

            for &v in &adj[u] {
                if v != parent[u] {
                    q.push_back((v, time + 1, new_profit));
                }
            }
        }

        max_profit
    }
}