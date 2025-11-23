var collectTheCoins = function(n, edges, coins) {
    if (n <= 1) return 0;

    const adj = Array.from({ length: n }, () => []);
    const degree = new Array(n).fill(0);

    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
        degree[u]++;
        degree[v]++;
    }

    // Phase 1: Prune nodes without coins that are leaves or become leaves.
    // Use a queue for BFS.
    const q = [];

    // Initialize q with leaves that don't have coins.
    // A node is considered a leaf if its degree is 1.
    for (let i = 0; i < n; i++) {
        if (degree[i] === 1 && coins[i] === 0) {
            q.push(i);
            degree[i] = 0; // Mark as removed by setting degree to 0
        }
    }

    while (q.length > 0) {
        const u = q.shift();
        for (const v of adj[u]) {
            if (degree[v] > 0) { // If neighbor v is not yet removed
                degree[v]--;
                if (degree[v] === 1 && coins[v] === 0) {
                    q.push(v);
                    degree[v] = 0; // Mark as removed
                }
            }
        }
    }

    // Phase 2: Two-level pruning on the remaining graph.
    // This step removes the outermost two layers of edges from the "coin-containing" part of the tree.
    // We achieve this by performing two rounds of leaf removal.

    const q2 = [];
    // Initialize q2 with leaves of the current (pruned) graph.
    // A node is a leaf if its degree is 1 and it's not already removed (degree > 0).
    for (let i = 0; i < n; i++) {
        if (degree[i] === 1) {
            q2.push(i);
            degree[i] = 0; // Mark as removed for this phase
        }
    }

    // Round 1 of 2-level pruning: Remove current leaves
    let current_q_size = q2.length;
    for (let k = 0; k < current_q_size; k++) {
        const u = q2.shift();
        for (const v of adj[u]) {
            if (degree[v] > 0) { // If neighbor v is not yet removed
                degree[v]--;
                if (degree[v] === 1) { // v becomes a new leaf
                    q2.push(v);
                    degree[v] = 0; // Mark as removed for the next round
                }
            }
        }
    }

    // Round 2 of 2-level pruning: Remove new leaves (which were parents of the first set of leaves)
    current_q_size = q2.length;
    for (let k = 0; k < current_q_size; k++) {
        const u = q2.shift();
        for (const v of adj[u]) {
            if (degree[v] > 0) { // If neighbor v is not yet removed
                degree[v]--;
                // No need to push to q2 again, as this is the final pruning round
            }
        }
    }

    // Phase 3: Count remaining edges.
    // The cost is 2 * (number of edges in the final remaining graph).
    let remaining_edges = 0;
    for (const [u, v] of edges) {
        if (degree[u] > 0 && degree[v] > 0) { // If both endpoints are still active
            remaining_edges++;
        }
    }

    return Math.max(0, 2 * remaining_edges);
};