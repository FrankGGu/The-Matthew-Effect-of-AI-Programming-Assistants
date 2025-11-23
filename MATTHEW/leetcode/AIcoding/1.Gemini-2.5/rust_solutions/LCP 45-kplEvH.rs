impl Solution {
    pub fn count_valid_paths(n: i32, edges: Vec<Vec<i32>>) -> i64 {
        let n_usize = n as usize;

        let is_prime = Self::sieve(n_usize);

        let mut adj: Vec<Vec<usize>> = vec![vec![]; n_usize + 1];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let total_paths = (n as i64) * (n as i64 + 1) / 2;

        let mut invalid_paths = 0;

        let mut visited: Vec<bool> = vec![false; n_usize + 1];

        for i in 1..=n_usize {
            if !is_prime[i] && !visited[i] {
                let mut component_size = 0;
                Self::dfs_count_component(i, &adj, &is_prime, &mut visited, &mut component_size);

                invalid_paths += component_size * (component_size + 1) / 2;
            }
        }

        total_paths - invalid_paths
    }

    fn sieve(n: usize) -> Vec<bool> {
        let mut is_prime = vec![true; n + 1];
        if n >= 0 { is_prime[0] = false; }
        if n >= 1 { is_prime[1] = false; }
        for p in 2..=n {
            if is_prime[p] {
                for multiple in (p * p..=n).step_by(p) {
                    is_prime[multiple] = false;
                }
            }
        }
        is_prime
    }

    fn dfs_count_component(
        u: usize,
        adj: &Vec<Vec<usize>>,
        is_prime: &Vec<bool>,
        visited: &mut Vec<bool>,
        component_size: &mut i64,
    ) {
        visited[u] = true;
        *component_size += 1;

        for &v in &adj[u] {
            if !is_prime[v] && !visited[v] {
                Self::dfs_count_component(v, adj, is_prime, visited, component_size);
            }
        }
    }
}