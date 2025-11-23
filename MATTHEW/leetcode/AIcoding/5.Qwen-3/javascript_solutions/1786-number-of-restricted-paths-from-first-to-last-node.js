function countRestrictedPaths(graph, k) {
    const MOD = 1000000007;
    const n = graph.length;
    const dist = new Array(n).fill(0);
    const visited = new Array(n).fill(false);
    const pq = [];

    const dijkstra = () => {
        dist[0] = 0;
        pq.push([0, 0]);
        while (pq.length > 0) {
            const [d, u] = pq.shift();
            if (visited[u]) continue;
            visited[u] = true;
            for (const v of graph[u]) {
                if (!visited[v] && dist[v] > d + 1) {
                    dist[v] = d + 1;
                    pq.push([dist[v], v]);
                }
            }
        }
    };

    dijkstra();

    const order = [...Array(n).keys()].sort((a, b) => dist[a] - dist[b]);

    const dp = new Array(n).fill(0);
    dp[n - 1] = 1;

    for (let i = 0; i < n; i++) {
        const u = order[i];
        for (const v of graph[u]) {
            if (dist[v] > dist[u]) {
                dp[v] = (dp[v] + dp[u]) % MOD;
            }
        }
    }

    return dp[0];
}