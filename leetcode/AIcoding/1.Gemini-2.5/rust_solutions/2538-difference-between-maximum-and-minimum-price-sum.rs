use std::cmp::{max, min};

struct Solution;

impl Solution {
    pub fn max_price_sum(n: i32, edges: Vec<Vec<i32>>, prices: Vec<i32>) -> i64 {
        let n = n as usize;
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut max_overall_path_sum: i64 = i64::MIN;
        let mut min_overall_path_sum: i64 = i64::MAX;

        // dfs returns (max_path_from_u_down, min_path_from_u_down)
        // These are max/min sums of paths starting at u and going down into its subtree,
        // including u.
        // max_path_from_u_down: prices[u] + max(0, max_path_from_v_down - prices[v]) for all children v.
        // min_path_from_u_down: prices[u] + min(0, min_path_from_v_down - prices[v]) for all children v.
        // The max(0, ...) ensures that we only extend a path if it's beneficial for the sum.
        // This returned value is used for extending paths upwards.
        fn dfs(
            u: usize,
            p: usize,
            adj: &Vec<Vec<usize>>,
            prices: &Vec<i32>,
            max_overall: &mut i64,
            min_overall: &mut i64,
        ) -> (i64, i64) {
            let mut max_child_gains: Vec<i64> = Vec::new(); // Stores max(0, max_path_from_v_down - prices[v])
            let mut min_child_gains: Vec<i64> = Vec::new(); // Stores min(0, min_path_from_v_down - prices[v])

            for &v in &adj[u] {
                if v == p {
                    continue;
                }
                let (max_res_v, min_res_v) = dfs(v, u, adj, prices, max_overall, min_overall);

                // Calculate the gain from extending a path through child v
                let max_gain_from_v = max(0, max_res_v - prices[v] as i64);
                let min_gain_from_v = min(0, min_res_v - prices[v] as i64);

                max_child_gains.push(max_gain_from_v);
                min_child_gains.push(min_gain_from_v);
            }

            // Sort child gains to find top 2 for LCA paths
            max_child_gains.sort_unstable_by(|a, b| b.cmp(a)); // Descending
            min_child_gains.sort_unstable_by(|a, b| a.cmp(b)); // Ascending

            let mut current_max_path_through_u = prices[u] as i64;
            let mut current_min_path_through_u = prices[u] as i64;

            // Paths that start at `u` and go down into one child's subtree.
            // These paths are guaranteed to be at least 2 nodes long if `max_child_gains[0]` > 0.
            // Or if `min_child_gains[0]` < 0.
            // But we need to consider all paths, not just beneficial ones.
            // The max/min_overall update logic should cover all paths.

            // For max_overall_path_sum:
            // Case 1: Path goes through u and one child branch.
            // Sum = prices[u] + max_child_gains[0] (if exists)
            if let Some(&gain) = max_child_gains.get(0) {
                current_max_path_through_u += gain;
                *max_overall = max(*max_overall, prices[u] as i64 + gain);
            } else {
                // If no children or no beneficial gains, current_max_path_through_u is just prices[u].
                // This is a 1-node path, not considered for max_overall_path_sum.
            }

            // Case 2: Path goes through u and two child branches (u is LCA).
            // Sum = prices[u] + max_child_gains[0] + max_child_gains[1] (if exist)
            if max_child_gains.len() >= 2 {
                let path_sum = prices[u] as i64 + max_child_gains[0] + max_child_gains[1];
                *max_overall = max(*max_overall, path_sum);
            }

            // For min_overall_path_sum:
            // Case 1: Path goes through u and one child branch.
            // Sum = prices[u] + min_child_gains[0] (if exists)
            if let Some(&gain) = min_child_gains.get(0) {
                current_min_path_through_u += gain;
                *min_overall = min(*min_overall, prices[u] as i64 + gain);
            } else {
                // If no children or no beneficial gains, current_min_path_through_u is just prices[u].
                // This is a 1-node path, not considered for min_overall_path_sum.
            }

            // Case 2: Path goes through u and two child branches (u is LCA).
            // Sum = prices[u] + min_child_gains[0] + min_child_gains[1] (if exist)
            if min_child_gains.len() >= 2 {
                let path_sum = prices[u] as i64 + min_child_gains[0] + min_child_gains[1];
                *min_overall = min(*min_overall, path_sum);
            }

            // The returned values are for extending paths upwards from u.
            // They represent paths starting at u and going down into one child branch.
            (current_max_path_through_u, current_min_path_through_u)
        }

        if n <= 1 {
            return 0;
        }

        // The initial call starts the DFS. Node 0 is an arbitrary root, n is a dummy parent.
        dfs(0, n, &adj, &prices, &mut max_overall_path_sum, &mut min_overall_path_sum);

        max_overall_path_sum - min_overall_path_sum
    }
}