function maxWeightedKEdgePath(n, edges, k) {
    const dp = Array.from({ length: n }, () => Array(k + 1).fill(-Infinity));
    for (let i = 0; i < n; i++) {
        dp[i][0] = 0;
    }

    for (let e = 1; e <= k; e++) {
        for (const [u, v, w] of edges) {
            if (dp[u][e - 1] !== -Infinity) {
                dp[v][e] = Math.max(dp[v][e], dp[u][e - 1] + w);
            }
        }
    }

    let max = -Infinity;
    for (let i = 0; i < n; i++) {
        max = Math.max(max, dp[i][k]);
    }

    return max === -Infinity ? -1 : max;
}