use std::cmp::max;

struct Solution;

impl Solution {
    pub fn maximize_sum_of_weights_after_edge_removals(n: i32, edges: Vec<Vec<i32>>, weights: Vec<i32>) -> i64 {
        let n = n as usize;
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut total_sum: i64 = 0;
        for &w in &weights {
            total_sum += w as i64;
        }

        let mut ans: i64 = total_sum;

        // dfs returns (subtree_sum, max_subtree_sum_val_in_this_subtree)
        // subtree_sum is the sum of weights of nodes in the subtree rooted at u.
        // max_subtree_sum_val_in_this_subtree is the maximum subtree sum (dp_sum[x])
        // for any node x within the subtree rooted at u (including u itself).
        fn dfs(
            u: usize,
            p: usize, // parent node, used to avoid going back up
            adj: &Vec<Vec<usize>>,
            weights: &Vec<i32>,
            total_sum: i64,
            ans: &mut i64,
        ) -> (i64, i64) {
            let mut dp_sum_u: i64 = weights[u] as i64;
            let mut max_s_in_subtree_u: i64 = weights[u] as i64;
            let mut child_max_s_in_subtree_list: Vec<i64> = Vec::new();

            for &v in &adj[u] {
                if v == p {
                    continue;
                }
                let (child_dp_sum, child_max_s_in_subtree) =
                    dfs(v, u, adj, weights, total_sum, ans);
                dp_sum_u += child_dp_sum;
                // max_s_in_subtree_u tracks the max subtree sum found so far in the current branch
                max_s_in_subtree_u = max(max_s_in_subtree_u, child_max_s_in_subtree);
                child_max_s_in_subtree_list.push(child_max_s_in_subtree);
            }

            // After processing all children, max_s_in_subtree_u should also consider dp_sum_u itself
            max_s_in_subtree_u = max(max_s_in_subtree_u, dp_sum_u);

            // Case 0: No cuts. Covered by initial ans = total_sum.

            // Case 1: One cut (edge (u, p)).
            // If we cut the edge connecting u to its parent p, the tree splits into two components:
            // T_u (subtree rooted at u, sum dp_sum_u) and T_rest (the rest of the tree, sum total_sum - dp_sum_u).
            // We want to maximize the sum of one of these components.
            *ans = max(*ans, dp_sum_u);
            if u != p { // If u is not the root (p is a dummy value for root's parent), (u, p) is a valid edge to cut.
                *ans = max(*ans, total_sum - dp_sum_u);
            }

            // Case 2a: Two cuts on the same path.
            // This means we cut the edge (u, p) and then another edge (x, parent_x) where x is in T_u.
            // The three components formed are:
            // 1. T_x (the largest subtree within T_u, sum max_s_in_subtree_u)
            // 2. T_u - T_x (the rest of T_u after removing T_x, sum dp_sum_u - max_s_in_subtree_u)
            // 3. T_rest (the component above u, sum total_sum - dp_sum_u)
            // We want to maximize the sum of one of these three components.
            *ans = max(*ans, max_s_in_subtree_u);
            if dp_sum_u - max_s_in_subtree_u > 0 { // Only if this component is non-empty
                *ans = max(*ans, dp_sum_u - max_s_in_subtree_u);
            }
            if u != p && total_sum - dp_sum_u > 0 { // Only if this component is non-empty
                *ans = max(*ans, total_sum - dp_sum_u);
            }

            // Case 2b: Two cuts creating three disjoint components.
            // This occurs when two edges are cut such that their corresponding subtrees are disjoint.
            // The most general way to find two disjoint subtrees is to consider two subtrees
            // rooted in different children's branches of the current node 'u'.
            // We sort `child_max_s_in_subtree_list` to find the two largest possible subtree sums
            // that are rooted in distinct children's branches. Let these be s1 and s2.
            // The three components would be T_s1, T_s2, and the remaining part of the tree (total_sum - s1 - s2).
            child_max_s_in_subtree_list.sort_unstable_by(|a, b| b.cmp(a));
            if child_max_s_in_subtree_list.len() >= 2 {
                let s1 = child_max_s_in_subtree_list[0];
                let s2 = child_max_s_in_subtree_list[1];
                *ans = max(*ans, s1);
                *ans = max(*ans, s2);
                if total_sum - s1 - s2 > 0 { // Only if this component is non-empty
                    *ans = max(*ans, total_sum - s1 - s2);
                }
            }

            (dp_sum_u, max_s_in_subtree_u)
        }

        // Start DFS from node 0 (arbitrary root).
        // For the root, we use `n` as a dummy parent index, which is guaranteed not to be a valid node index.
        dfs(0, n, &adj, &weights, total_sum, &mut ans);

        ans
    }
}