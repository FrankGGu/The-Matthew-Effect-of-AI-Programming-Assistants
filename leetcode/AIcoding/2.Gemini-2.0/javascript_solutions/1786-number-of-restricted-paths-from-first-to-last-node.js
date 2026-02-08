var countRestrictedPaths = function(n, edges) {
    const graph = Array(n + 1).fill(null).map(() => []);
    for (const [u, v, w] of edges) {
        graph[u].push([v, w]);
        graph[v].push([u, w]);
    }

    const dist = Array(n + 1).fill(Infinity);
    dist[n] = 0;
    const pq = [[n, 0]];

    while (pq.length > 0) {
        pq.sort((a, b) => a[1] - b[1]);
        const [u, d] = pq.shift();

        if (d > dist[u]) continue;

        for (const [v, w] of graph[u]) {
            if (dist[v] > dist[u] + w) {
                dist[v] = dist[u] + w;
                pq.push([v, dist[v]]);
            }
        }
    }

    const dp = Array(n + 1).fill(0);
    dp[n] = 1;
    const MOD = 10**9 + 7;

    function dfs(u) {
        if (dp[u] !== 0) return dp[u];

        let count = 0;
        for (const [v, w] of graph[u]) {
            if (dist[v] < dist[u]) {
                count = (count + dfs(v)) % MOD;
            }
        }
        dp[u] = count;
        return count;
    }

    return dfs(1);
};