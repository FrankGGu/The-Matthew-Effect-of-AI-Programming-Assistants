var minimumWeight = function(n, edges, src1, src2, dest) {
    const buildGraph = (edges) => {
        const graph = new Array(n).fill().map(() => []);
        for (const [u, v, w] of edges) {
            graph[u].push([v, w]);
        }
        return graph;
    };

    const dijkstra = (graph, start) => {
        const dist = new Array(n).fill(Infinity);
        dist[start] = 0;
        const heap = new MinPriorityQueue({ priority: (x) => x[1] });
        heap.enqueue([start, 0]);

        while (!heap.isEmpty()) {
            const [u, currentDist] = heap.dequeue().element;
            if (currentDist > dist[u]) continue;
            for (const [v, w] of graph[u]) {
                if (dist[v] > dist[u] + w) {
                    dist[v] = dist[u] + w;
                    heap.enqueue([v, dist[v]]);
                }
            }
        }
        return dist;
    };

    const forwardGraph = buildGraph(edges);
    const reverseGraph = buildGraph(edges.map(([u, v, w]) => [v, u, w]));

    const distSrc1 = dijkstra(forwardGraph, src1);
    const distSrc2 = dijkstra(forwardGraph, src2);
    const distDest = dijkstra(reverseGraph, dest);

    let minWeight = Infinity;
    for (let i = 0; i < n; i++) {
        if (distSrc1[i] === Infinity || distSrc2[i] === Infinity || distDest[i] === Infinity) continue;
        const total = distSrc1[i] + distSrc2[i] + distDest[i];
        if (total < minWeight) {
            minWeight = total;
        }
    }

    return minWeight === Infinity ? -1 : minWeight;
};