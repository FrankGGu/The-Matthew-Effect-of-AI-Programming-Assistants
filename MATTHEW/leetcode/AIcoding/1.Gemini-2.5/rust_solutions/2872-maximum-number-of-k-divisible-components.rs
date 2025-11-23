struct Solution;

impl Solution {
    fn dfs(
        u: usize,
        p: usize,
        adj: &Vec<Vec<usize>>,
        values: &Vec<i32>,
        k: i32,
        components_count: &mut i32,
    ) -> i64 {
        let mut current_sum: i64 = values[u] as i64;

        for &v in &adj[u] {
            if v == p {
                continue;
            }
            current_sum += Self::dfs(v, u, adj, values, k, components_count);
        }

        if current_sum % (k as i64) == 0 {
            *components_count += 1;
            0
        } else {
            current_sum
        }
    }

    pub fn max_k_divisible_components(n: i32, edges: Vec<Vec<i32>>, values: Vec<i32>, k: i32) -> i32 {
        let n_usize = n as usize;
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n_usize];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut components_count = 0;
        Self::dfs(0, n_usize, &adj, &values, k, &mut components_count);

        components_count
    }
}