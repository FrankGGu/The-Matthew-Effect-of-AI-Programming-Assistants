impl Solution {
    pub fn maximum_sum_of_edge_values(n: i32, edges: Vec<Vec<i32>>, values: Vec<i32>) -> i64 {
        let n_usize = n as usize;
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n_usize];
        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut total_max_sum: i64 = 0;

        // Iterate over each bit position
        // Max value of values[i] is 10^9, which is less than 2^30.
        // So we need to check bits from 0 to 29.
        for b in 0..30 {
            // Case 1: The b-th bit of K (the global XOR constant) is 0.
            // In this case, x_i (flip state of node i) has no effect on the b-th bit of node values.
            // The b-th bit of an edge (u,v) is simply (values[u]>>b & 1) ^ (values[v]>>b & 1).
            let mut sum_bit_k0: i64 = 0;
            for edge in &edges {
                let u = edge[0] as usize;
                let v = edge[1] as usize;
                let bit_u = (values[u] >> b) & 1;
                let bit_v = (values[v] >> b) & 1;
                sum_bit_k0 += (bit_u ^ bit_v) as i64;
            }

            // Case 2: The b-th bit of K is 1.
            // In this case, x_i affects the b-th bit of node values.
            // We use tree DP to find the maximum possible sum of b-th bits.
            // dp[u][0]: max sum of b-th bits from edges in subtree u, if x_u = 0.
            // dp[u][1]: max sum of b-th bits from edges in subtree u, if x_u = 1.
            let (dp0_root, dp1_root) = Self::dfs(0, n_usize, &adj, &values, b);
            let sum_bit_k1 = std::cmp::max(dp0_root, dp1_root);

            // Choose the better option for this bit and add to total sum.
            total_max_sum += std::cmp::max(sum_bit_k0, sum_bit_k1) * (1i64 << b);
        }

        total_max_sum
    }

    // DFS function for a single bit 'b'
    // Returns (max_sum_if_u_state_0, max_sum_if_u_state_1)
    fn dfs(u: usize, p: usize, adj: &Vec<Vec<usize>>, values: &Vec<i32>, b: i32) -> (i64, i64) {
        let mut dp_u0 = 0; // max sum of b-th bits if x_u = 0
        let mut dp_u1 = 0; // max sum of b-th bits if x_u = 1

        let bit_u = (values[u] >> b) & 1;

        for &v in &adj[u] {
            if v == p {
                continue;
            }

            let (dp_v0, dp_v1) = Self::dfs(v, u, adj, values, b);
            let bit_v = (values[v] >> b) & 1;

            // Edge (u,v) contribution
            // If x_u and x_v are the same, the edge contributes (bit_u ^ bit_v).
            let edge_val_if_same_state = (bit_u ^ bit_v) as i64;
            // If x_u and x_v are different, the edge contributes (bit_u ^ bit_v ^ 1).
            let edge_val_if_diff_state = ((bit_u ^ bit_v) ^ 1) as i64;

            // Calculate dp_u0: max sum if x_u = 0
            // Option 1: x_v = 0. Edge (u,v) contributes edge_val_if_same_state. Subtree v contributes dp_v0.
            // Option 2: x_v = 1. Edge (u,v) contributes edge_val_if_diff_state. Subtree v contributes dp_v1.
            dp_u0 += std::cmp::max(dp_v0 + edge_val_if_same_state, dp_v1 + edge_val_if_diff_state);

            // Calculate dp_u1: max sum if x_u = 1
            // Option 1: x_v = 0. Edge (u,v) contributes edge_val_if_diff_state. Subtree v contributes dp_v0.
            // Option 2: x_v = 1. Edge (u,v) contributes edge_val_if_same_state. Subtree v contributes dp_v1.
            dp_u1 += std::cmp::max(dp_v0 + edge_val_if_diff_state, dp_v1 + edge_val_if_same_state);
        }

        (dp_u0, dp_u1)
    }
}