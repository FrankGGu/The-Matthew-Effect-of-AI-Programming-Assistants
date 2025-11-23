var countRestrictedPaths = function(n, edges) {
    const graph = Array.from({ length: n + 1 }, () => []);
    for (const [u, v, w] of edges) {
        graph[u].push([v, w]);
        graph[v].push([u, w]);
    }

    const dist = Array(n + 1).fill(Infinity);
    dist[n] = 0;
    const pq = [[0, n]];

    while (pq.length) {
        const [d, node] = pq.shift();
        if (d > dist[node]) continue;
        for (const [neighbor, weight] of graph[node]) {
            if (dist[neighbor] > dist[node] + weight) {
                dist[neighbor] = dist[node] + weight;
                pq.push([dist[neighbor], neighbor]);
                pq.sort((a, b) => a[0] - b[0]);
            }
        }
    }

    const mod = 1e9 + 7;
    const dp = Array(n + 1).fill(0);
    dp[1] = 1;

    for (let i = 1; i <= n; i++) {
        const node = [...Array(n + 1).keys()].sort((a, b) => dist[a] - dist[b]);
        for (const u of node) {
            for (const [v] of graph[u]) {
                if (dist[u] > dist[v]) {
                    dp[u] = (dp[u] + dp[v]) % mod;
                }
            }
        }
    }

    return dp[n];
};