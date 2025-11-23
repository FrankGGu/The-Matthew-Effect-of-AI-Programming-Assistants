var minimizeTotalPrice = function(n, edges, price, trips) {
    const adj = Array.from({ length: n }, () => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    // --- LCA Preprocessing ---
    const MAX_LOG = Math.floor(Math.log2(n)) + 1;
    const depth = new Array(n).fill(0);
    const up = Array.from({ length: n }, () => new Array(MAX_LOG).fill(-1));

    const dfsLcaPrep = (u, p, d) => {
        depth[u] = d;
        up[u][0] = p;
        for (let k = 1; k < MAX_LOG; k++) {
            if (up[u][k-1] !== -1) {
                up[u][k] = up[up[u][k-1]][k-1];
            } else {
                up[u][k] = -1; // No 2^k-th ancestor if 2^(k-1)-th ancestor doesn't exist
            }
        }
        for (const v of adj[u]) {
            if (v !== p) {
                dfsLcaPrep(v, u, d + 1);
            }
        }
    };
    dfsLcaPrep(0, -1, 0); // Start DFS from node 0, parent -1, depth 0

    const getLCA = (u, v) => {
        if (depth[u] < depth[v]) {
            [u, v] = [v, u]; // Swap to ensure u is deeper or at same depth as v
        }

        // Lift u to the same depth as v
        for (let k = MAX_LOG - 1; k >= 0; k--) {
            if (up[u][k] !== -1 && depth[up[u][k]] >= depth[v]) {
                u = up[u][k];
            }
        }

        if (u === v) {
            return u;
        }

        // Lift u and v simultaneously
        for (let k = MAX_LOG - 1; k >= 0; k--) {
            if (up[u][k] !== -1 && up[v][k] !== -1 && up[u][k] !== up[v][k]) {
                u = up[u][k];
                v = up[v][k];
            }
        }
        return up[u][0]; // Parent of the first common ancestor
    };

    // --- Calculate Node Frequencies ---
    // nodeTripCount[i] will store the number of times node i is visited across all trips
    const nodeTripCount = new Array(n).fill(0);
    for (const [start, end] of trips) {
        const lca = getLCA(start, end);
        nodeTripCount[start]++;
        nodeTripCount[end]++;
        nodeTripCount[lca]--;
        if (up[lca][0] !== -1) { // If LCA is not the root (has a parent)
            nodeTripCount[up[lca][0]]--;
        }
    }

    // Propagate counts from children to parents
    const dfsCalculateCounts = (u, p) => {
        for (const v of adj[u]) {
            if (v !== p) {
                dfsCalculateCounts(v, u);
                nodeTripCount[u] += nodeTripCount[v];
            }
        }
    };
    dfsCalculateCounts(0, -1); // Start DFS from node 0

    // --- Tree DP ---
    // dp[u][0]: min cost for subtree rooted at u, where u's price is NOT halved
    // dp[u][1]: min cost for subtree rooted at u, where u's price IS halved
    const dfsTreeDP = (u, p) => {
        let costNotHalved = nodeTripCount[u] * price[u];
        let costHalved = nodeTripCount[u] * Math.floor(price[u] / 2);

        for (const v of adj[u]) {
            if (v !== p) {
                const childDP = dfsTreeDP(v, u);
                costNotHalved += Math.min(childDP[0], childDP[1]);
                costHalved += childDP[0]; // If u is halved, its child v cannot be halved
            }
        }
        return [costNotHalved, costHalved];
    };

    const finalDP = dfsTreeDP(0, -1);
    return Math.min(finalDP[0], finalDP[1]);
};