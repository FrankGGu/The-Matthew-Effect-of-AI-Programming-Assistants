var findRedundantDirectedConnection = function(edges) {
    const n = edges.length;

    // DSU structure
    let parent_dsu = Array(n + 1).fill(0).map((_, i) => i);

    function find(i) {
        if (parent_dsu[i] === i) {
            return i;
        }
        parent_dsu[i] = find(parent_dsu[i]);
        return parent_dsu[i];
    }

    function union(i, j) {
        const rootI = find(i);
        const rootJ = find(j);
        if (rootI !== rootJ) {
            parent_dsu[rootJ] = rootI;
            return true;
        }
        return false;
    }

    // Phase 1: Detect node with in-degree 2
    let parent_map = Array(n + 1).fill(0); // parent_map[v] stores u if u -> v is the first edge to v
    let candidate1 = null; // The first edge leading to a node with in-degree 2
    let candidate2 = null; // The second edge leading to a node with in-degree 2

    for (const edge of edges) {
        const u = edge[0];
        const v = edge[1];
        if (parent_map[v] !== 0) { // v already has a parent
            candidate1 = [parent_map[v], v];
            candidate2 = edge;
            break; // Found the node with two parents, we have our two candidates
        }
        parent_map[v] = u;
    }

    // Phase 2: Handle cases based on in-degree 2 detection

    if (candidate1 !== null) { // Case 1: A node with in-degree 2 was found
        // Try removing candidate2 (the later edge)
        // Reset DSU for this check
        parent_dsu = Array(n + 1).fill(0).map((_, i) => i);

        let cycleDetected = false;
        for (const edge of edges) {
            // Check if current edge is candidate2 (by value comparison)
            if (edge[0] === candidate2[0] && edge[1] === candidate2[1]) {
                continue; // Skip candidate2
            }
            const u = edge[0];
            const v = edge[1];
            if (!union(u, v)) { // If union returns false, it means u and v are already connected
                cycleDetected = true;
                break; // Cycle detected with candidate2 removed
            }
        }

        if (cycleDetected) {
            // Removing candidate2 still resulted in a cycle, so candidate1 must be the redundant edge
            return candidate1;
        } else {
            // Removing candidate2 resolved the issue (no cycle, no other in-degree 2), so candidate2 is the answer
            return candidate2;
        }

    } else { // Case 2: No node with in-degree 2 was found (all nodes have in-degree at most 1)
        // The redundant edge must form a cycle. We need the LAST such edge.
        let last_cycle_edge = null;

        // Reset DSU for this check (though it's already in its initial state if candidate1 was null)
        parent_dsu = Array(n + 1).fill(0).map((_, i) => i);

        for (const edge of edges) {
            const u = edge[0];
            const v = edge[1];
            if (!union(u, v)) { // If union returns false, it means u and v are already connected
                last_cycle_edge = edge; // This edge forms a cycle, store it (we need the last one)
            }
        }
        return last_cycle_edge;
    }
};