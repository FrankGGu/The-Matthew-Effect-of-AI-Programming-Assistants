var minimumWeight = function(n, edges, src1, src2, dest) {
    const buildGraph = (edges) => {
        const graph = Array(n).fill(null).map(() => []);
        for (const [u, v, w] of edges) {
            graph[u].push([v, w]);
        }
        return graph;
    };

    const buildReverseGraph = (edges) => {
        const graph = Array(n).fill(null).map(() => []);
        for (const [u, v, w] of edges) {
            graph[v].push([u, w]);
        }
        return graph;
    };

    const dijkstra = (graph, start) => {
        const dist = Array(n).fill(Infinity);
        dist[start] = 0;
        const pq = [[0, start]];

        while (pq.length > 0) {
            pq.sort((a, b) => a[0] - b[0]);
            const [d, u] = pq.shift();

            if (d > dist[u]) continue;

            for (const [v, w] of graph[u]) {
                if (dist[u] + w < dist[v]) {
                    dist[v] = dist[u] + w;
                    pq.push([dist[v], v]);
                }
            }
        }

        return dist;
    };

    const graph = buildGraph(edges);
    const reverseGraph = buildReverseGraph(edges);

    const dist1 = dijkstra(graph, src1);
    const dist2 = dijkstra(graph, src2);
    const distDest = dijkstra(reverseGraph, dest);

    let minWeight = Infinity;
    for (let i = 0; i < n; i++) {
        minWeight = Math.min(minWeight, dist1[i] + dist2[i] + distDest[i]);
    }

    return minWeight === Infinity ? -1 : minWeight;
};