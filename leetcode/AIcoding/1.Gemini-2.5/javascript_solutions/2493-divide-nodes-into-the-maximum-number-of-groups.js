function divideNodesIntoMaximumGroups(n, edges) {
    const adj = Array(n).fill(0).map(() => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    let maxOverallGroups = 0;

    // Handle edge cases for n=0 or n=1
    if (n === 0) {
        return 0;
    }
    if (n === 1) {
        return 1;
    }

    // The problem asks for the maximum number of groups `k` such that
    // for any two connected nodes, they belong to different groups.
    // This is equivalent to finding the longest path (in terms of number of nodes)
    // in the graph. If the longest path has `L` nodes, we can assign them groups
    // 1, 2, ..., L. For other nodes, we can assign groups such that the condition
    // is met and the total number of groups is maximized.
    // The maximum number of groups will be `L`.
    // For an unweighted, undirected graph, the longest path can be found by
    // running a BFS from each node and finding the maximum depth reached.

    for (let i = 0; i < n; i++) {
        // `group[j]` stores the group number assigned to node `j`
        // or 0 if `j` has not been visited in the current BFS.
        const group = Array(n).fill(0); 
        const q = [];
        let head = 0; // Pointer for efficient queue operations (simulating shift)

        q.push(i);
        group[i] = 1; // Start node is assigned to group 1
        let currentMaxDepth = 1; // Tracks the maximum group number in the current BFS

        while (head < q.length) {
            const u = q[head++];
            currentMaxDepth = Math.max(currentMaxDepth, group[u]);

            for (const v of adj[u]) {
                if (group[v] === 0) { // If neighbor `v` has not been visited
                    group[v] = group[u] + 1; // Assign `v` to the next group
                    q.push(v);
                }
            }
        }
        // Update the overall maximum number of groups found so far
        maxOverallGroups = Math.max(maxOverallGroups, currentMaxDepth);
    }

    return maxOverallGroups;
}