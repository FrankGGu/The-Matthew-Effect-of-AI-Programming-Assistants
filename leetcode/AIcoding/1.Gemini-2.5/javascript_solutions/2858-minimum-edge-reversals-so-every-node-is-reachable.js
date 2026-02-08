var minEdgeReversals = function(n, edges) {
    const adj = Array(n).fill(0).map(() => []);

    for (const [u, v] of edges) {
        // For an original edge u -> v:
        // Add [v, 0] to u's adjacency list (cost 0 for u -> v).
        // Add [u, 1] to v's adjacency list (cost 1 for v -> u, as it's a reversal of u -> v).
        adj[u].push([v, 0]); 
        adj[v].push([u, 1]); 
    }

    const downCost = Array(n).fill(0); // downCost[u] stores min reversals in the subtree rooted at u, if u is the root of its subtree.
    const ans = Array(n).fill(0);      // ans[u] stores the total min reversals if u is chosen as the global root.

    // DFS1: Calculate downCost for an arbitrary root (e.g., node 0).
    // This function computes the cost to make all nodes in the subtree of 'u' reachable from 'u'.
    function dfs1(u, p) {
        let currentCost = 0;
        for (const [v, cost] of adj[u]) {
            if (v === p) continue;
            currentCost += cost;        // Add cost if the edge u -> v (in the tree sense) is a reversal.
            currentCost += dfs1(v, u);  // Recursively add cost from the subtree rooted at v.
        }
        downCost[u] = currentCost;
        return currentCost;
    }

    // DFS2: Use rerooting DP to calculate total reversals for each node as the global root.
    // ans[u] is the total reversals if u is the global root.
    function dfs2(u, p) {
        for (const [v, cost] of adj[u]) {
            if (v === p) continue;

            // When moving the global root from u to its child v:
            // The edge between u and v changes its role.
            // `cost` here refers to the cost of traversing from u to v.
            if (cost === 0) { // Original edge was u -> v.
                // If u was root, u -> v cost 0.
                // If v becomes root, the path to u's parent goes v -> u.
                // v -> u is a reversal of the original u -> v, so it costs 1.
                // Thus, ans[v] = ans[u] - (cost of u->v from u's perspective) + (cost of v->u from v's perspective)
                ans[v] = ans[u] - 0 + 1;
            } else { // Original edge was v -> u.
                // If u was root, u -> v cost 1 (as it's a reversal of v -> u).
                // If v becomes root, the path to u's parent goes v -> u.
                // v -> u is an original edge, so it costs 0.
                ans[v] = ans[u] - 1 + 0;
            }
            dfs2(v, u);
        }
    }

    // Start DFS1 from node 0 (arbitrary root) to populate downCost and get the initial answer for root 0.
    dfs1(0, -1);
    ans[0] = downCost[0]; // The total cost if node 0 is the global root.

    // Start DFS2 from node 0 to propagate the root cost to all other nodes.
    dfs2(0, -1);

    return ans;
};