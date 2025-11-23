use std::collections::VecDeque;

impl Solution {
    pub fn maximum_score_after_operations_on_tree(parents: Vec<i32>, nums: Vec<i32>) -> i64 {
        let n = parents.len();
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n];

        // Build adjacency list for children
        for i in 1..n {
            adj[parents[i] as usize].push(i);
        }

        // `dfs_recursive` returns a tuple `(score_if_u_is_taken, score_if_u_is_not_taken)`.
        // `score_if_u_is_taken`: Maximum score from the subtree rooted at `u`,
        //                       assuming an operation is applied on `u`. This means `nums[u]` is added
        //                       to the score, and `u` is "cleared" (its `nums` value becomes 0) for its parent.
        //                       For this to happen, all children `v` of `u` must also have operations applied
        //                       on them (i.e., they must be in their "taken" state).
        // `score_if_u_is_not_taken`: Maximum score from the subtree rooted at `u`,
        //                           assuming an operation is NOT applied on `u`. This means `nums[u]` is
        //                           NOT added to the score, and `u` is "NOT cleared" (its `nums` value remains)
        //                           for its parent. If `u` is not cleared, its parent cannot apply an operation.
        //                           For this state, each child `v` of `u` can be either "taken" or "not taken",
        //                           whichever yields a higher score for `v`'s subtree.
        let mut memo = vec![None; n];

        fn dfs_recursive(u: usize, adj: &Vec<Vec<usize>>, nums: &Vec<i32>, memo: &mut Vec<Option<(i64, i64)>>) -> (i64, i64) {
            if let Some(res) = memo[u] {
                return res;
            }

            // `taken_score` for node `u`:
            // We add `nums[u]` and the `taken_score` from all its children.
            let mut taken_score = nums[u] as i64;

            // `not_taken_score` for node `u`:
            // We don't add `nums[u]`. We sum the maximum of `taken_score` and `not_taken_score`
            // from each child.
            let mut not_taken_score = 0;

            for &v in &adj[u] {
                let (child_taken_score, child_not_taken_score) = dfs_recursive(v, adj, nums, memo);

                // If `u` is taken, all its children `v` must also be taken (i.e., `nums[v]` becomes 0).
                taken_score += child_taken_score;

                // If `u` is not taken, its children `v` can be either taken or not taken,
                // whichever maximizes their subtree score.
                not_taken_score += child_taken_score.max(child_not_taken_score);
            }

            memo[u] = Some((taken_score, not_taken_score));
            (taken_score, not_taken_score)
        }

        let (root_taken, root_not_taken) = dfs_recursive(0, &adj, &nums, &mut memo);

        // The final answer is the maximum of the score if the root is taken,
        // and the score if the root is not taken.
        root_taken.max(root_not_taken)
    }
}