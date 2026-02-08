var countPaths = function(n, roads) {
    const adj = Array(n).fill(null).map(() => []);
    for (const [u, v, w] of roads) {
        adj[u].push([v, w]);
        adj[v].push([u, w]);
    }

    const dist = Array(n).fill(Infinity);
    const ways = Array(n).fill(0);
    dist[0] = 0;
    ways[0] = 1;

    const pq = [[0, 0]]; // [distance, node]

    while (pq.length > 0) {
        pq.sort((a, b) => a[0] - b[0]);
        const [d, u] = pq.shift();

        if (d > dist[u]) continue;

        for (const [v, w] of adj[u]) {
            if (dist[v] > dist[u] + w) {
                dist[v] = dist[u] + w;
                ways[v] = ways[u];
                pq.push([dist[v], v]);
            } else if (dist[v] === dist[u] + w) {
                ways[v] = (ways[v] + ways[u]) % (10**9 + 7);
            }
        }
    }

    return ways[n - 1];
};