var eventualSafeStates = function(graph) {
    const n = graph.length;
    // 0: unvisited
    // 1: visiting (currently in recursion stack, potential cycle)
    // 2: safe (all paths from this node lead to terminal nodes)
    // 3: unsafe (leads to a cycle or is part of one)
    const colors = new Array(n).fill(0);
    const safeStates = [];

    function dfs(u) {
        // If the node's state is already determined, return it
        if (colors[u] !== 0) {
            return colors[u] === 2; // True if safe, false if unsafe (1 or 3)
        }

        // Mark the current node as visiting
        colors[u] = 1;

        // Explore all neighbors
        for (const v of graph[u]) {
            // If any neighbor leads to an unsafe state (or is part of a cycle)
            if (!dfs(v)) {
                colors[u] = 3; // Mark current node u as unsafe
                return false;
            }
        }

        // If all neighbors lead to safe states, then the current node u is safe
        colors[u] = 2; // Mark current node u as safe
        return true;
    }

    // Iterate through all nodes to ensure DFS is run for every component
    for (let i = 0; i < n; i++) {
        dfs(i);
    }

    // Collect all nodes that were determined to be safe
    for (let i = 0; i < n; i++) {
        if (colors[i] === 2) {
            safeStates.push(i);
        }
    }

    return safeStates;
};