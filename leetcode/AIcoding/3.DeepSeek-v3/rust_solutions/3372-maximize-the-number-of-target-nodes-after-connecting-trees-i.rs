use std::collections::HashSet;

impl Solution {
    pub fn maximum_target_nodes(edges: Vec<Vec<i32>>, k: i32) -> i32 {
        let n = edges.len() + 1;
        let mut adj = vec![vec![]; n];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut max_count = 0;
        for i in 0..n {
            let mut visited = HashSet::new();
            visited.insert(i);
            let count = Self::dfs(&adj, i, k, &mut visited);
            max_count = max_count.max(count);
        }
        max_count
    }

    fn dfs(adj: &Vec<Vec<usize>>, u: usize, k: i32, visited: &mut HashSet<usize>) -> i32 {
        let mut count = 1;
        for &v in &adj[u] {
            if !visited.contains(&v) {
                visited.insert(v);
                if k > 0 {
                    count += Self::dfs(adj, v, k - 1, visited);
                }
            }
        }
        count
    }
}