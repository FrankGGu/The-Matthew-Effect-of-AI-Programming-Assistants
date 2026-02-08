use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn longest_special_path(edges: Vec<Vec<i32>>, labels: String) -> i32 {
        let n = edges.len() + 1;
        let mut adj = vec![vec![]; n];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }
        let labels = labels.chars().collect::<Vec<_>>();
        let mut max_len = 1;

        fn dfs(u: usize, parent: usize, adj: &Vec<Vec<usize>>, labels: &Vec<char>, max_len: &mut i32) -> i32 {
            let mut max1 = 0;
            let mut max2 = 0;
            for &v in &adj[u] {
                if v == parent {
                    continue;
                }
                let child_len = dfs(v, u, adj, labels, max_len);
                if labels[u] == labels[v] {
                    continue;
                }
                if child_len > max1 {
                    max2 = max1;
                    max1 = child_len;
                } else if child_len > max2 {
                    max2 = child_len;
                }
            }
            *max_len = (*max_len).max(1 + max1 + max2);
            1 + max1
        }

        dfs(0, usize::MAX, &adj, &labels, &mut max_len);
        max_len
    }
}