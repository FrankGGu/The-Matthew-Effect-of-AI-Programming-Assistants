var numberOfWays = function(n, edges, k) {
    const MOD = 10**9 + 7;
    const m = edges.length;

    // Step 1: Build adjacency list with edge IDs
    const adj = Array(n).fill(0).map(() => []);
    for (let i = 0; i < m; i++) {
        const [u, v] = edges[i];
        adj[u].push([v, i]);
        adj[v].push([u, i]);
    }

    // Step 2: Find bridges using Tarjan's algorithm (DFS based)
    const disc = Array(n).fill(-1); // Discovery time
    const low = Array(n).fill(-1);  // Lowest discovery time reachable
    const visited = Array(n).fill(false);
    const isBridge = Array(m).fill(false);
    let time = 0;

    function dfsFindBridges(u, pEdgeId) {
        visited[u] = true;
        disc[u] = low[u] = time++;

        for (const [v, edgeId] of adj[u]) {
            if (edgeId === pEdgeId) {
                continue; // Skip parent edge
            }
            if (visited[v]) {
                // Back-edge or cross-edge to an already visited node
                low[u] = Math.min(low[u], disc[v]);
            } else {
                // Tree-edge
                dfsFindBridges(v, edgeId);
                low[u] = Math.min(low[u], low[v]);
                if (low[v] > disc[u]) {
                    // If the lowest reachable time from v is strictly greater than u's discovery time,
                    // then (u,v) is a bridge.
                    isBridge[edgeId] = true;
                }
            }
        }
    }

    // The problem states the graph is connected, so we can start DFS from node 0.
    dfsFindBridges(0, -1);

    // Step 3: Precompute factorials modulo MOD
    const factorial = Array(m + 1);
    factorial[0] = 1;
    for (let i = 1; i <= m; i++) {
        factorial[i] = (factorial[i - 1] * i) % MOD;
    }

    // Step 4: Traverse the graph again to count edges in each 2-edge-connected component (2-ECC)
    // and calculate the total number of ways.
    let totalWays = 1;
    const visitedBCC = Array(n).fill(false);
    const edgeVisitedInBCC = Array(m).fill(false);

    function dfsCountEdgesInBCC(u, currentBCCEdges) {
        visitedBCC[u] = true;
        for (const [v, edgeId] of adj[u]) {
            if (isBridge[edgeId]) {
                continue; // Skip bridges
            }
            if (!edgeVisitedInBCC[edgeId]) {
                edgeVisitedInBCC[edgeId] = true;
                currentBCCEdges.count++;
            }
            if (!visitedBCC[v]) {
                dfsCountEdgesInBCC(v, currentBCCEdges);
            }
        }
    }

    for (let i = 0; i < n; i++) {
        if (!visitedBCC[i]) {
            const currentBCCEdges = { count: 0 };
            dfsCountEdgesInBCC(i, currentBCCEdges);
            if (currentBCCEdges.count > 0) {
                // If currentBCCEdges.count is 0, it means node i was isolated or only connected by bridges
                // and has no non-bridge edges to contribute to a BCC.
                totalWays = (totalWays * factorial[currentBCCEdges.count]) % MOD;
            }
        }
    }

    return totalWays;
};