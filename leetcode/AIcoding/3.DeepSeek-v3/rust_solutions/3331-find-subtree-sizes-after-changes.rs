use std::collections::{HashMap, HashSet};

struct Solution;

impl Solution {
    pub fn subtree_sizes_after_changes(n: i32, edges: Vec<Vec<i32>>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let n = n as usize;
        let mut adj = vec![HashSet::new(); n];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].insert(v);
            adj[v].insert(u);
        }

        let mut parent = vec![0; n];
        let mut size = vec![0; n];
        let mut root = 0;
        Self::dfs(root, n, &adj, &mut parent, &mut size);

        let mut res = Vec::new();
        let mut current_adj = adj.clone();
        for query in queries {
            let u = query[0] as usize;
            let v = query[1] as usize;
            if current_adj[u].contains(&v) {
                current_adj[u].remove(&v);
                current_adj[v].remove(&u);
                if Self::is_parent(u, v, &parent) {
                    root = v;
                } else {
                    root = u;
                }
            } else {
                current_adj[u].insert(v);
                current_adj[v].insert(u);
                if Self::is_parent(u, v, &parent) {
                    root = u;
                } else {
                    root = v;
                }
            }
            Self::dfs(root, n, &current_adj, &mut parent, &mut size);
            res.push(size[root] as i32);
        }
        res
    }

    fn dfs(u: usize, parent_node: usize, adj: &[HashSet<usize>], parent: &mut [usize], size: &mut [usize]) {
        parent[u] = parent_node;
        size[u] = 1;
        for &v in adj[u].iter() {
            if v != parent_node {
                Self::dfs(v, u, adj, parent, size);
                size[u] += size[v];
            }
        }
    }

    fn is_parent(u: usize, v: usize, parent: &[usize]) -> bool {
        let mut node = v;
        while node != u && node != parent[node] {
            node = parent[node];
        }
        node == u
    }
}