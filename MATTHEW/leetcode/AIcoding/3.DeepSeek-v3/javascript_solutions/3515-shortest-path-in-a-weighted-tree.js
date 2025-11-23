var shortestPath = function(n, edges, query) {
    const adj = Array.from({ length: n + 1 }, () => []);
    for (const [u, v, w] of edges) {
        adj[u].push([v, w]);
        adj[v].push([u, w]);
    }

    const [start, end] = query;
    if (start === end) return 0;

    const heap = new MinPriorityQueue({ priority: (x) => x[1] });
    heap.enqueue([start, 0]);
    const dist = new Array(n + 1).fill(Infinity);
    dist[start] = 0;

    while (!heap.isEmpty()) {
        const [u, currentDist] = heap.dequeue().element;
        if (u === end) return currentDist;
        if (currentDist > dist[u]) continue;

        for (const [v, w] of adj[u]) {
            const newDist = currentDist + w;
            if (newDist < dist[v]) {
                dist[v] = newDist;
                heap.enqueue([v, newDist]);
            }
        }
    }

    return -1;
};