function maxWeightKEdgePath(n, edges, k, start, end) {
    const graph = Array.from({length: n}, () => []);
    for (const [u, v, weight] of edges) {
        graph[u].push([v, weight]);
        graph[v].push([u, weight]);
    }

    const dp = Array.from({length: n}, () => Array(k + 1).fill(-Infinity));
    dp[start][0] = 0;

    for (let edgeCount = 0; edgeCount < k; edgeCount++) {
        for (let u = 0; u < n; u++) {
            if (dp[u][edgeCount] === -Infinity) continue;
            for (const [v, weight] of graph[u]) {
                dp[v][edgeCount + 1] = Math.max(dp[v][edgeCount + 1], dp[u][edgeCount] + weight);
            }
        }
    }

    let result = -Infinity;
    for (let edgeCount = 0; edgeCount <= k; edgeCount++) {
        result = Math.max(result, dp[end][edgeCount]);
    }

    return result === -Infinity ? 0 : result;
}