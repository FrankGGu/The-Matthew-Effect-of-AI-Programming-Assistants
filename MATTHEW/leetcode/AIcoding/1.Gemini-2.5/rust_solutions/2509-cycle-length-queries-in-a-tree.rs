struct Solution;

impl Solution {
    pub fn cycle_length_queries(n: i32, queries: Vec<Vec<i32>>) -> Vec<i32> {
        const MAX_LOG_N: usize = 17; // ceil(log2(10^5)) is 17

        let n_usize = n as usize;

        let mut depth = vec![0; n_usize + 1];
        let mut parent = vec![vec![0; MAX_LOG_N]; n_usize + 1];

        depth[1] = 0;
        parent[1][0] = 0;

        for i in 2..=n_usize {
            depth[i] = depth[i / 2] + 1;
            parent[i][0] = i / 2;
        }

        for k in 1..MAX_LOG_N {
            for i in 1..=n_usize {
                parent[i][k] = parent[parent[i][k - 1]][k - 1];
            }
        }

        let mut results = Vec::with_capacity(queries.len());

        for query in queries {
            let u_orig = query[0] as usize;
            let v_orig = query[1] as usize;

            let mut u = u_orig;
            let mut v = v_orig;

            if depth[u] < depth[v] {
                std::mem::swap(&mut u, &mut v);
            }

            for k in (0..MAX_LOG_N).rev() {
                if depth[u] - (1 << k) >= depth[v] {
                    u = parent[u][k];
                }
            }

            let lca_node;
            if u == v {
                lca_node = u;
            } else {
                for k in (0..MAX_LOG_N).rev() {
                    if parent[u][k] != parent[v][k] {
                        u = parent[u][k];
                        v = parent[v][k];
                    }
                }
                lca_node = parent[u][0];
            }

            let cycle_length = depth[u_orig] + depth[v_orig] - 2 * depth[lca_node] + 1;
            results.push(cycle_length as i32);
        }

        results
    }
}