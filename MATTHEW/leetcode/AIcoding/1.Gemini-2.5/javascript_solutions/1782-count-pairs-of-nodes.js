var countPairsOfNodes = function(n, edges, queries) {
    const degrees = new Array(n + 1).fill(0);
    const adj = new Array(n + 1).fill(null).map(() => new Set());

    for (const [u, v] of edges) {
        degrees[u]++;
        degrees[v]++;
        adj[u].add(v);
        adj[v].add(u);
    }

    // common_neighbor_counts[k] will store the number of pairs (u, v) with u < v
    // such that common_neighbors(u, v) = k.
    // The maximum possible number of common neighbors for any pair (u, v) is n - 2.
    // So, an array of size n is sufficient (indices 0 to n-1).
    const common_neighbor_counts = new Array(n).fill(0);

    // Iterate over all possible pairs (u, v) with u < v
    for (let u = 1; u <= n; u++) {
        for (let v = u + 1; v <= n; v++) {
            let currentCommonNeighbors = 0;

            // Optimize the common neighbor calculation by iterating over the smaller adjacency list
            let smallerAdj = adj[u];
            let largerAdj = adj[v];
            if (adj[u].size > adj[v].size) {
                [smallerAdj, largerAdj] = [largerAdj, smallerAdj];
            }

            for (const w of smallerAdj) {
                if (largerAdj.has(w)) {
                    currentCommonNeighbors++;
                }
            }
            common_neighbor_counts[currentCommonNeighbors]++;
        }
    }

    // Compute suffix sums for efficient querying
    // suffix_common_neighbor_counts[k] will store the number of pairs (u, v)
    // such that common_neighbors(u, v) >= k.
    const suffix_common_neighbor_counts = new Array(n).fill(0);

    // Initialize the last element
    suffix_common_neighbor_counts[n - 1] = common_neighbor_counts[n - 1];

    // Calculate suffix sums from right to left
    for (let k = n - 2; k >= 0; k--) {
        suffix_common_neighbor_counts[k] = suffix_common_neighbor_counts[k + 1] + common_neighbor_counts[k];
    }

    const results = [];
    for (const q of queries) {
        // We need pairs where common_neighbors > q.
        // This corresponds to common_neighbors >= q + 1.
        // So, we look up suffix_common_neighbor_counts[q + 1].

        if (q + 1 >= n) { 
            // If q + 1 is out of bounds (e.g., q + 1 >= n),
            // it means no pair can have common_neighbors >= q + 1,
            // so the count is 0.
            results.push(0);
        } else {
            results.push(suffix_common_neighbor_counts[q + 1]);
        }
    }

    return results;
};