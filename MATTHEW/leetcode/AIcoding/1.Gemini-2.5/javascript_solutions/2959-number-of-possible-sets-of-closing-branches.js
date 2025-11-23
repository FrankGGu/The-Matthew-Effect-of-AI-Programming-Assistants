var numberOfSets = function(n, maxDistance, roads, k) {
    let count = 0;

    // Iterate through all possible subsets of branches to consider as 'open'
    // Each `mask` represents a set of open branches.
    for (let mask = 0; mask < (1 << n); mask++) {
        const openBranches = [];
        for (let i = 0; i < n; i++) {
            if ((mask >> i) & 1) { // If branch `i` is included in the current set of open branches
                openBranches.push(i);
            }
        }

        // If the number of open branches does not match `n - k` (meaning `k` closed branches), skip this subset.
        if (openBranches.length !== n - k) {
            continue;
        }

        // Create a temporary distance matrix for the current set of open branches.
        // Initialize all distances to Infinity, and self-distances to 0.
        const currentDist = Array(n).fill(0).map(() => Array(n).fill(Infinity));
        for (const branch of openBranches) {
            currentDist[branch][branch] = 0;
        }

        // Populate `currentDist` with direct road weights, but only if both endpoints are open branches.
        for (const [u, v, w] of roads) {
            // Check if both `u` and `v` are in the current set of open branches (using the mask).
            if (((mask >> u) & 1) && ((mask >> v) & 1)) {
                currentDist[u][v] = Math.min(currentDist[u][v], w);
                currentDist[v][u] = Math.min(currentDist[v][u], w);
            }
        }

        // Run Floyd-Warshall algorithm on the current set of open branches.
        // The intermediate node `p` must also be an open branch.
        for (const p of openBranches) {
            for (const i of openBranches) {
                for (const j of openBranches) {
                    if (currentDist[i][p] !== Infinity && currentDist[p][j] !== Infinity) {
                        currentDist[i][j] = Math.min(currentDist[i][j], currentDist[i][p] + currentDist[p][j]);
                    }
                }
            }
        }

        // Calculate the maximum distance among all pairs of distinct open branches.
        let maxPath = 0;
        let possible = true; // Flag to check if all open branches are connected

        // Only need to check distances if there are at least two open branches.
        // If 0 or 1 open branches, maxPath remains 0, which is valid.
        if (openBranches.length >= 2) {
            for (let i = 0; i < openBranches.length; i++) {
                for (let j = i + 1; j < openBranches.length; j++) {
                    const b1 = openBranches[i];
                    const b2 = openBranches[j];
                    if (currentDist[b1][b2] === Infinity) {
                        possible = false; // Found two open branches that are disconnected
                        break;
                    }
                    maxPath = Math.max(maxPath, currentDist[b1][b2]);
                }
                if (!possible) break; // Exit outer loop if disconnected
            }
        }

        // If all open branches are connected and their maximum distance is within `maxDistance`,
        // increment the count of valid sets.
        if (possible && maxPath <= maxDistance) {
            count++;
        }
    }

    return count;
};