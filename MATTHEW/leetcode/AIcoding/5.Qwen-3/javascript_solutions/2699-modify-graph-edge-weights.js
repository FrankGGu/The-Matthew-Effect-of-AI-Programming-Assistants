function modifyGraph(n, edges, source, destination, target) {
    const graph = new Array(n).fill(0).map(() => []);

    for (const [u, v, w] of edges) {
        graph[u].push([v, w]);
        graph[v].push([u, w]);
    }

    function dijkstra(start) {
        const dist = new Array(n).fill(Infinity);
        dist[start] = 0;
        const pq = [[0, start]];

        while (pq.length > 0) {
            const [d, u] = pq.shift();
            if (d > dist[u]) continue;
            for (const [v, w] of graph[u]) {
                if (dist[v] > d + w) {
                    dist[v] = d + w;
                    pq.push([dist[v], v]);
                }
            }
        }

        return dist;
    }

    const dist = dijkstra(source);

    if (dist[destination] > target) return null;

    for (const edge of edges) {
        const [u, v, w] = edge;
        if (w !== -1) continue;

        const originalDist = dist[destination];
        const newW = target - (dist[u] + dist[v]);

        if (newW < 0) continue;

        edge[2] = newW;
        graph[u].push([v, newW]);
        graph[v].push([u, newW]);

        const newDist = dijkstra(source);
        if (newDist[destination] === target) {
            return edges;
        }
    }

    return null;
}