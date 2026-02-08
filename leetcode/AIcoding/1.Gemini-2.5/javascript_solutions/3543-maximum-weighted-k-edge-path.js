var maxWeightedKEdgePath = function(n, edges, k) {
    const adj = Array(n).fill(0).map(() => []);
    for (const [u, v, w] of edges) {
        adj[u].push([v, w]);
    }

    const dp = Array(k + 1).fill(0).map(() => Array(n).fill(-Infinity));

    for (let i = 0; i < n; i++) {
        dp[0][i] = 0;
    }

    for (let i = 1; i <= k; i++) {
        for (let u = 0; u < n; u++) {
            if (dp[i - 1][u] === -Infinity) {
                continue;
            }
            for (const [v, weight] of adj[u]) {
                dp[i][v] = Math.max(dp[i][v], dp[i - 1][u] + weight);
            }
        }
    }

    let maxWeight = -Infinity;
    for (let i = 0; i < n; i++) {
        maxWeight = Math.max(maxWeight, dp[k][i]);
    }

    return maxWeight === -Infinity ? -1 : maxWeight;
};