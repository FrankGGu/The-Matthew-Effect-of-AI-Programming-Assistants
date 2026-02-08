var findAnswer = function(n, edges) {
    const adj = new Array(n).fill().map(() => []);
    for (const [u, v, w] of edges) {
        adj[u].push([v, w]);
        adj[v].push([u, w]);
    }

    const dijkstra = (start) => {
        const dist = new Array(n).fill(Infinity);
        dist[start] = 0;
        const heap = new MinPriorityQueue({ priority: (x) => x[1] });
        heap.enqueue([start, 0]);

        while (!heap.isEmpty()) {
            const [u, d] = heap.dequeue().element;
            if (d > dist[u]) continue;
            for (const [v, w] of adj[u]) {
                if (dist[v] > dist[u] + w) {
                    dist[v] = dist[u] + w;
                    heap.enqueue([v, dist[v]]);
                }
            }
        }
        return dist;
    };

    const distFrom0 = dijkstra(0);
    const distFromN = dijkstra(n - 1);
    const totalDist = distFrom0[n - 1];
    if (totalDist === Infinity) return new Array(edges.length).fill(false);

    const result = [];
    for (const [u, v, w] of edges) {
        const isPart = (distFrom0[u] + w + distFromN[v] === totalDist) || 
                       (distFrom0[v] + w + distFromN[u] === totalDist);
        result.push(isPart);
    }
    return result;
};