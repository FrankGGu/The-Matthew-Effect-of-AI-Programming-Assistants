var maximumScoreAfterOperations = function(n, values, edges, k) {
    const adj = Array.from({ length: n }, () => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    // This DFS function computes the maximum score for the subtree rooted at 'u'.
    // It returns a tuple: [dp_table, subtree_node_count]
    // dp_table[j][0]: max score for the current subtree, selecting 'j' nodes, root 'u' is NOT selected.
    // dp_table[j][1]: max score for the current subtree, selecting 'j' nodes, root 'u' IS selected.
    // Initialize with -1 to represent unreachable states.
    function dfs(u, p) {
        // dp_u will store the DP states for the subtree rooted at u.
        // It's an array of size (k + 1) x 2.
        const dp_u = Array.from({ length: k + 1 }, () => [-1, -1]);
        let current_subtree_node_count = 1; // Count of nodes in subtree rooted at u, including processed children.

        // Base case: Initialize dp for node u itself.
        // If u is not selected, 0 nodes selected, score 0.
        dp_u[0][0] = 0;
        // If u is selected, 1 node selected, score values[u].
        // This is only possible if k >= 1. The problem constraints state 1 <= k <= n, so k is always at least 1.
        dp_u[1][1] = values[u];

        for (const v of adj[u]) {
            if (v === p) continue; // Skip parent

            // Recursively call DFS for child v to get its DP table and subtree size.
            const [dp_v, subtree_node_count_v] = dfs(v, u);

            // Create a temporary DP table for merging results from dp_u and dp_v.
            // The maximum number of operations possible after merging is limited by k
            // and the total number of nodes in the merged subtree.
            const new_dp_size = Math.min(k, current_subtree_node_count + subtree_node_count_v) + 1;
            const new_dp = Array.from({ length: new_dp_size }, () => [-1, -1]);

            // Merge dp_u (current combined results for u and its already processed children) with dp_v (results for subtree v)

            // Case 1: Node u is NOT selected (contributing to new_dp[][0])
            for (let j_u = 0; j_u <= Math.min(k, current_subtree_node_count); j_u++) {
                if (dp_u[j_u][0] === -1) continue; // Skip if this state for u is unreachable

                for (let j_v = 0; j_v <= Math.min(k - j_u, subtree_node_count_v); j_v++) {
                    // If u is not selected, its child v can be selected or not selected.
                    // We take the maximum possible score from v's subtree.
                    let max_score_from_v = -1;
                    if (dp_v[j_v][0] !== -1) { // v not selected
                        max_score_from_v = Math.max(max_score_from_v, dp_v[j_v][0]);
                    }
                    if (dp_v[j_v][1] !== -1) { // v selected
                        max_score_from_v = Math.max(max_score_from_v, dp_v[j_v][1]);
                    }

                    if (max_score_from_v !== -1) {
                        const current_total_ops = j_u + j_v;
                        new_dp[current_total_ops][0] = Math.max(new_dp[current_total_ops][0], dp_u[j_u][0] + max_score_from_v);
                    }
                }
            }

            // Case 2: Node u IS selected (contributing to new_dp[][1])
            for (let j_u = 0; j_u <= Math.min(k, current_subtree_node_count); j_u++) {
                if (dp_u[j_u][1] === -1) continue; // Skip if this state for u is unreachable

                for (let j_v = 0; j_v <= Math.min(k - j_u, subtree_node_count_v); j_v++) {
                    // If u is selected, its child v CANNOT be selected (due to adjacency rule).
                    // So we must take dp_v[j_v][0] (v not selected).
                    if (dp_v[j_v][0] === -1) continue; // Skip if this state for v is unreachable

                    const current_total_ops = j_u + j_v;
                    new_dp[current_total_ops][1] = Math.max(new_dp[current_total_ops][1], dp_u[j_u][1] + dp_v[j_v][0]);
                }
            }

            // Update dp_u with the merged results from new_dp.
            // dp_u is always of size (k+1). new_dp might be smaller.
            // Copy values from new_dp and reset any remaining entries in dp_u to -1.
            for (let j = 0; j <= k; j++) {
                if (j < new_dp_size) {
                    dp_u[j][0] = new_dp[j][0];
                    dp_u[j][1] = new_dp[j][1];
                } else {
                    dp_u[j][0] = -1;
                    dp_u[j][1] = -1;
                }
            }
            // Update the total node count for the subtree rooted at u.
            current_subtree_node_count += subtree_node_count_v;
        }
        return [dp_u, current_subtree_node_count];
    }

    // Start DFS from the root (node 0), with a dummy parent -1.
    const [final_dp_table, _] = dfs(0, -1);

    // The final answer is the maximum score for exactly 'k' operations,
    // considering either the root node 0 was selected or not selected.
    return Math.max(final_dp_table[k][0], final_dp_table[k][1]);
};