var shortestPath = function(n, edges, start, end) {
    const adj = Array(n).fill(null).map(() => []);
    for (const [u, v, w] of edges) {
        adj[u].push([v, w]);
        adj[v].push([u, w]);
    }

    const dist = Array(n).fill(Infinity);
    dist[start] = 0;
    const pq = [[0, start]];

    while (pq.length > 0) {
        pq.sort((a, b) => a[0] - b[0]);
        const [d, u] = pq.shift();

        if (d > dist[u]) continue;

        for (const [v, w] of adj[u]) {
            if (dist[v] > dist[u] + w) {
                dist[v] = dist[u] + w;
                pq.push([dist[v], v]);
            }
        }
    }

    return dist[end] === Infinity ? -1 : dist[end];
};