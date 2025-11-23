struct Solution;

impl Solution {
    pub fn number_of_coins(n: i32, edges: Vec<Vec<i32>>, values: Vec<i32>) -> Vec<i64> {
        let n_usize = n as usize;
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n_usize];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut ans: Vec<i64> = vec![0; n_usize];

        // Call DFS from root (node 0), with a dummy parent (n_usize, which is an invalid index)
        Self::dfs(0, n_usize, &adj, &values, &mut ans);

        ans
    }

    // Returns (count_of_nodes_in_subtree, trimmed_list_of_values)
    // trimmed_list_of_values contains at most 5 elements: 2 smallest, 3 largest from the subtree
    fn dfs(u: usize, parent: usize, adj: &[Vec<usize>], values: &[i32], ans: &mut Vec<i64>) -> (usize, Vec<i32>) {
        let mut current_count = 1;
        let mut all_subtree_values = vec![values[u]];

        for &v in &adj[u] {
            if v == parent {
                continue;
            }
            let (child_count, child_trimmed_values) = Self::dfs(v, u, adj, values, ans);
            current_count += child_count;
            all_subtree_values.extend(child_trimmed_values);
        }

        all_subtree_values.sort_unstable(); // Sort all values collected from children and current node

        // Calculate ans[u]
        if current_count < 3 {
            ans[u] = 0;
        } else {
            let n_vals = all_subtree_values.len();

            // Products can exceed i64, use i128 for intermediate calculation to prevent overflow
            let v1 = all_subtree_values[n_vals - 1] as i128;
            let v2 = all_subtree_values[n_vals - 2] as i128;
            let v3 = all_subtree_values[n_vals - 3] as i128;

            let prod1 = v1 * v2 * v3;

            let s1 = all_subtree_values[0] as i128;
            let s2 = all_subtree_values[1] as i128;
            let prod2 = s1 * s2 * v1; // Note: v1 is the largest value

            ans[u] = prod1.max(prod2).max(0) as i64;
        }

        // Prepare return value for parent: trimmed list of 2 smallest and 3 largest
        let mut trimmed_result = Vec::new();
        if all_subtree_values.len() <= 5 {
            trimmed_result = all_subtree_values; // If fewer than 5, just return all
        } else {
            // Take the two smallest
            trimmed_result.push(all_subtree_values[0]);
            trimmed_result.push(all_subtree_values[1]);
            // Take the three largest
            let n_vals = all_subtree_values.len();
            trimmed_result.push(all_subtree_values[n_vals - 3]);
            trimmed_result.push(all_subtree_values[n_vals - 2]);
            trimmed_result.push(all_subtree_values[n_vals - 1]);
            // The elements are taken from sorted positions, so trimmed_result will also be sorted.
        }

        (current_count, trimmed_result)
    }
}