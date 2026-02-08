struct Solution;

impl Solution {
    const LOGN: usize = 14; // ceil(log2(10^4)) = 14
    const MAX_WEIGHT: usize = 26;

    // Adjacency list: (neighbor, weight)
    static mut ADJ: Vec<Vec<(usize, i32)>> = Vec::new();
    // Depth of each node
    static mut DEPTH: Vec<usize> = Vec::new();
    // parent[k][u] is the 2^k-th ancestor of u
    static mut PARENT: Vec<Vec<usize>> = Vec::new();
    // counts[u][w] is the number of edges with weight w on the path from root to u
    static mut COUNTS: Vec<Vec<usize>> = Vec::new();

    unsafe fn dfs(u: usize, p: usize, d: usize, edge_weight_to_u: i32) {
        Self::DEPTH[u] = d;
        Self::PARENT[0][u] = p;

        if u != p { // If not root, copy counts from parent and increment for the edge (p, u)
            Self::COUNTS[u].clone_from(&Self::COUNTS[p]);
            Self::COUNTS[u][edge_weight_to_u as usize] += 1;
        } else { // If root, its counts are all zeros, already initialized
            // No action needed as COUNTS[0] is already vec![0; MAX_WEIGHT + 1]
        }

        for &(v, weight) in Self::ADJ[u].iter() {
            if v != p {
                Self::dfs(v, u, d + 1, weight);
            }
        }
    }

    unsafe fn get_lca(mut u: usize, mut v: usize) -> usize {
        // Bring u to the same depth as v
        if Self::DEPTH[u] < Self::DEPTH[v] {
            std::mem::swap(&mut u, &mut v);
        }

        for k in (0..Self::LOGN).rev() {
            if Self::DEPTH[u] - (1 << k) >= Self::DEPTH[v] {
                u = Self::PARENT[k][u];
            }
        }

        if u == v {
            return u;
        }

        // Lift u and v simultaneously
        for k in (0..Self::LOGN).rev() {
            if Self::PARENT[k][u] != Self::PARENT[k][v] {
                u = Self::PARENT[k][u];
                v = Self::PARENT[k][v];
            }
        }

        Self::PARENT[0][u]
    }

    pub fn min_operations_for_equilibrium(n: i32, edges: Vec<Vec<i32>>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let n_usize = n as usize;

        unsafe {
            // Initialize static variables for the current test case
            Self::ADJ = vec![vec![]; n_usize];
            Self::DEPTH = vec![0; n_usize];
            Self::PARENT = vec![vec![0; n_usize]; Self::LOGN];
            Self::COUNTS = vec![vec![0; Self::MAX_WEIGHT + 1]; n_usize];

            // Build adjacency list
            for edge in edges {
                let u = edge[0] as usize;
                let v = edge[1] as usize;
                let w = edge[2];
                Self::ADJ[u].push((v, w));
                Self::ADJ[v].push((u, w));
            }

            // DFS to populate depth, parent[0], and counts
            // Root (node 0) has parent 0, depth 0. Dummy edge_weight_to_u 0 is fine as COUNTS[0] is initialized to zeros.
            Self::dfs(0, 0, 0, 0); 

            // Binary lifting precomputation for parents
            for k in 1..Self::LOGN {
                for u in 0..n_usize {
                    Self::PARENT[k][u] = Self::PARENT[k - 1][Self::PARENT[k - 1][u]];
                }
            }

            let mut results = Vec::with_capacity(queries.len());
            for query in queries {
                let u = query[0] as usize;
                let v = query[1] as usize;
                let target_weight = query[2] as usize;

                let lca = Self::get_lca(u, v);

                // Total edges on path u-v
                let total_edges_on_path = Self::DEPTH[u] + Self::DEPTH[v] - 2 * Self::DEPTH[lca];

                // Count of target_weight edges on path u-v
                // This is (count from root to u) + (count from root to v) - 2 * (count from root to lca)
                let count_target_weight = Self::COUNTS[u][target_weight] + Self::COUNTS[v][target_weight] - 2 * Self::COUNTS[lca][target_weight];

                // The number of edges to change is total edges minus those already having target_weight
                results.push((total_edges_on_path - count_target_weight) as i32);
            }

            results
        }
    }
}