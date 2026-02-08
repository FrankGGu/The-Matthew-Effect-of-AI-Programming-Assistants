var minimumWeight = function(n, edges, src1, src2, dest) {
    const adj = Array(n).fill(null).map(() => []);
    const revAdj = Array(n).fill(null).map(() => []);

    for (const [u, v, w] of edges) {
        adj[u].push([v, w]);
        revAdj[v].push([u, w]);
    }

    const dijkstra = (start, graph) => {
        const dist = Array(n).fill(Infinity);
        dist[start] = 0;
        const pq = [[0, start]];

        while (pq.length) {
            pq.sort((a, b) => a[0] - b[0]);
            const [d, u] = pq.shift();

            if (d > dist[u]) continue;

            for (const [v, w] of graph[u]) {
                if (dist[v] > dist[u] + w) {
                    dist[v] = dist[u] + w;
                    pq.push([dist[v], v]);
                }
            }
        }
        return dist;
    };

    const dist1 = dijkstra(src1, adj);
    const dist2 = dijkstra(src2, adj);
    const distDest = dijkstra(dest, revAdj);

    let minWeight = Infinity;
    for (let i = 0; i < n; i++) {
        minWeight = Math.min(minWeight, dist1[i] + dist2[i] + distDest[i]);
    }

    return minWeight === Infinity ? -1 : minWeight;
};