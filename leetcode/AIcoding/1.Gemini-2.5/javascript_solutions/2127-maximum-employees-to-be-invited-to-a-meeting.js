var maximumInvitations = function(favorite) {
    const n = favorite.length;

    // Step 1: Build reverse adjacency list and calculate in-degrees for the forward graph
    const adjRev = Array(n).fill(0).map(() => []);
    const inDegree = Array(n).fill(0);
    for (let i = 0; i < n; i++) {
        adjRev[favorite[i]].push(i);
        inDegree[favorite[i]]++;
    }

    // Step 2: Find all cycle nodes and calculate max length of cycles > 2
    // Use DFS for cycle detection
    const visited = Array(n).fill(0); // 0: unvisited, 1: visiting (on current recursion stack), 2: visited
    const pathNodes = []; // Stores nodes in current DFS path
    const pathIndices = Array(n).fill(-1); // Stores index in pathNodes for cycle detection
    const cycleNodesSet = new Set();
    let maxLenGt2Cycles = 0;

    function findCyclesDFS(u) {
        visited[u] = 1;
        pathIndices[u] = pathNodes.length;
        pathNodes.push(u);

        const v = favorite[u];

        if (visited[v] === 0) { // Not visited, recurse
            findCyclesDFS(v);
        } else if (visited[v] === 1) { // Cycle detected (v is on current recursion stack)
            const cycleStartIdx = pathIndices[v];
            const cycleLen = pathNodes.length - cycleStartIdx;

            if (cycleLen > 2) {
                maxLenGt2Cycles = Math.max(maxLenGt2Cycles, cycleLen);
            }
            // Add all nodes in this cycle to cycleNodesSet
            for (let i = cycleStartIdx; i < pathNodes.length; i++) {
                cycleNodesSet.add(pathNodes[i]);
            }
        }

        pathNodes.pop();
        pathIndices[u] = -1;
        visited[u] = 2; // Mark as fully visited
    }

    for (let i = 0; i < n; i++) {
        if (visited[i] === 0) {
            findCyclesDFS(i);
        }
    }

    // Step 3: Calculate max_depth_from_branch for each node
    // max_depth_from_branch[u] is the length of the longest path p_k -> ... -> p_1 -> u
    // where p_i are not cycle nodes.
    const branchDepth = Array(n).fill(0);
    const q = [];
    const tempInDegree = [...inDegree]; // Use a copy as we'll modify it

    // Initialize queue with non-cycle nodes that have an in-degree of 0
    for (let i = 0; i < n; i++) {
        if (!cycleNodesSet.has(i) && tempInDegree[i] === 0) {
            q.push(i);
        }
    }

    while (q.length > 0) {
        const u = q.shift();
        const v = favorite[u]; // Node u points to v

        // Update branchDepth for v
        branchDepth[v] = Math.max(branchDepth[v], branchDepth[u] + 1);

        // Decrement in-degree for v
        tempInDegree[v]--;

        // If v is not a cycle node and its in-degree becomes 0, add it to queue
        if (!cycleNodesSet.has(v) && tempInDegree[v] === 0) {
            q.push(v);
        }
    }

    // Step 4: Sum up for 2-cycles with branches
    let sumTwoCyclesWithBranches = 0;
    const visited2CyclePairs = new Set(); // To avoid double counting 2-cycles

    for (let i = 0; i < n; i++) {
        const u = i;
        const v = favorite[i];
        if (favorite[v] === u && u !== v) { // Found a 2-cycle u <-> v
            // Ensure we process each 2-cycle only once
            const pairKey = Math.min(u, v) + '-' + Math.max(u, v);
            if (!visited2CyclePairs.has(pairKey)) {
                // For a 2-cycle (u,v), we invite u, v, and all nodes in the longest branches leading into them.
                sumTwoCyclesWithBranches += (2 + branchDepth[u] + branchDepth[v]);
                visited2CyclePairs.add(pairKey);
            }
        }
    }

    // Step 5: The final answer is the maximum of the two types of structures
    return Math.max(sumTwoCyclesWithBranches, maxLenGt2Cycles);
};