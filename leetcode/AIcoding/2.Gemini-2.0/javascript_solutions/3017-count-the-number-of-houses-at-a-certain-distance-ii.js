var countOfPairs = function(n, edges, distanceThreshold) {
    const adj = Array(n).fill(null).map(() => []);
    for (const [u, v, w] of edges) {
        adj[u].push([v, w]);
        adj[v].push([u, w]);
    }

    const result = [];
    for (const threshold of distanceThreshold) {
        let count = 0;
        for (let i = 0; i < n; i++) {
            for (let j = i + 1; j < n; j++) {
                const dist = dijkstra(n, adj, i, j);
                if (dist <= threshold) {
                    count++;
                }
            }
        }
        result.push(count);
    }
    return result;

    function dijkstra(n, adj, start, end) {
        const dist = Array(n).fill(Infinity);
        dist[start] = 0;
        const visited = Array(n).fill(false);
        const pq = [[0, start]];

        while (pq.length > 0) {
            pq.sort((a, b) => a[0] - b[0]);
            const [d, u] = pq.shift();

            if (visited[u]) continue;
            visited[u] = true;

            if (u === end) return d;

            for (const [v, w] of adj[u]) {
                if (dist[v] > dist[u] + w) {
                    dist[v] = dist[u] + w;
                    pq.push([dist[v], v]);
                }
            }
        }

        return Infinity;
    }
};