var minimumWeight = function(n, edges, src1, src2, dest) {
    const buildGraph = () => {
        const graph = Array.from({ length: n }, () => []);
        for (const [u, v, w] of edges) {
            graph[u].push([v, w]);
        }
        return graph;
    };

    const dijkstra = (start, graph) => {
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

    const forwardGraph = buildGraph();
    const reverseGraph = Array.from({ length: n }, () => []);
    for (const [u, v, w] of edges) {
        reverseGraph[v].push([u, w]);
    }

    const dist1 = dijkstra(src1, forwardGraph);
    const dist2 = dijkstra(src2, forwardGraph);
    const distDest = dijkstra(dest, reverseGraph);

    let minWeight = Infinity;
    for (let i = 0; i < n; i++) {
        if (dist1[i] !== Infinity && dist2[i] !== Infinity && distDest[i] !== Infinity) {
            const total = dist1[i] + dist2[i] + distDest[i];
            if (total < minWeight) {
                minWeight = total;
            }
        }
    }

    return minWeight === Infinity ? -1 : minWeight;
};