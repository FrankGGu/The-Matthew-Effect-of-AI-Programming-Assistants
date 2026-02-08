struct Solution;

impl Solution {
    pub fn min_time(n: i32, edges: Vec<Vec<i32>>, has_apple: Vec<bool>) -> i32 {
        let n_usize = n as usize;
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n_usize];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut total_time = 0;
        Self::dfs(0, n_usize, &adj, &has_apple, &mut total_time);
        total_time
    }

    fn dfs(u: usize, parent: usize, adj: &Vec<Vec<usize>>, has_apple: &Vec<bool>, total_time: &mut i32) -> bool {
        let mut has_apple_in_subtree = has_apple[u];

        for &v in &adj[u] {
            if v == parent {
                continue;
            }

            if Self::dfs(v, u, adj, has_apple, total_time) {
                has_apple_in_subtree = true;
                *total_time += 2;
            }
        }

        has_apple_in_subtree
    }
}