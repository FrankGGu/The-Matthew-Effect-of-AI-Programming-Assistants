var countVisitedNodes = function(n, edges) {
    const ans = new Array(n).fill(0);
    const state = new Array(n).fill(0); // 0: unvisited, 1: visiting (on current path), 2: visited (processed)

    for (let i = 0; i < n; i++) {
        if (state[i] === 0) { // If node i is unvisited, start a traversal
            let curr = i;
            const path = []; // Stores nodes in the current traversal path
            const path_idx = new Array(n).fill(-1); // Stores index of node in 'path' array for O(1) cycle detection

            // Traverse until we hit a node that's already in the current path (cycle)
            // or a node that has been fully processed (state === 2)
            while (state[curr] === 0) {
                state[curr] = 1; // Mark as visiting
                path_idx[curr] = path.length; // Record its index in the path
                path.push(curr);
                curr = edges[curr];
            }

            if (state[curr] === 1) { // Cycle detected: curr is already in the current path
                const cycleStartIdx = path_idx[curr];
                const cycleLength = path.length - cycleStartIdx;

                // Assign cycle length to all nodes in the cycle
                for (let j = cycleStartIdx; j < path.length; j++) {
                    ans[path[j]] = cycleLength;
                    state[path[j]] = 2; // Mark as fully processed
                }

                // Assign counts for nodes in the tail leading to the cycle
                for (let j = cycleStartIdx - 1; j >= 0; j--) {
                    ans[path[j]] = ans[edges[path[j]]] + 1;
                    state[path[j]] = 2; // Mark as fully processed
                }
            } else { // state[curr] === 2: curr is already fully processed
                // All nodes in 'path' form a tail leading to 'curr'
                // Calculate counts by working backwards from 'curr'
                for (let j = path.length - 1; j >= 0; j--) {
                    ans[path[j]] = ans[edges[path[j]]] + 1;
                    state[path[j]] = 2; // Mark as fully processed
                }
            }
        }
    }

    return ans;
};