var maxProfit = function(n, dependencies, profits) {
    if (n === 0) {
        return 0;
    }

    const adj = Array(n).fill(0).map(() => []);
    const inDegree = Array(n).fill(0);
    const dp = Array(n).fill(0); 

    // Initialize dp[i] with the profit of node i itself.
    // dp[i] will store the maximum profit of any path ending at node i.
    for (let i = 0; i < n; i++) {
        dp[i] = profits[i];
    }

    // Build adjacency list and calculate in-degrees for topological sort.
    for (const [u, v] of dependencies) {
        adj[u].push(v);
        inDegree[v]++;
    }

    const queue = [];
    // Add all nodes with an in-degree of 0 to the queue. These are the starting points for paths.
    for (let i = 0; i < n; i++) {
        if (inDegree[i] === 0) {
            queue.push(i);
        }
    }

    let head = 0;
    // Process nodes in topological order.
    while (head < queue.length) {
        const u = queue[head++]; // Dequeue a node

        // For each neighbor v of u (i.e., there's an edge u -> v)
        for (const v of adj[u]) {
            // Update dp[v]: The maximum profit of a path ending at v
            // can either be its current value (from another path)
            // or by extending the path that ends at u (dp[u]) and adding profit[v].
            dp[v] = Math.max(dp[v], dp[u] + profits[v]);

            // Decrement in-degree of v, as u has been processed.
            inDegree[v]--;
            // If v's in-degree becomes 0, it means all its prerequisites have been processed,
            // so it can be added to the queue for further processing.
            if (inDegree[v] === 0) {
                queue.push(v);
            }
        }
    }

    // The maximum profit is the maximum value found in the dp array.
    // This covers paths ending at any node, including source nodes,
    // or nodes that have no outgoing edges.
    return Math.max(...dp);
};