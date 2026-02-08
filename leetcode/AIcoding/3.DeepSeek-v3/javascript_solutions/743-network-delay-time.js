var networkDelayTime = function(times, n, k) {
    const graph = new Array(n + 1).fill().map(() => []);
    for (const [u, v, w] of times) {
        graph[u].push([v, w]);
    }

    const dist = new Array(n + 1).fill(Infinity);
    dist[k] = 0;

    const heap = new MinPriorityQueue({ priority: x => x[1] });
    heap.enqueue([k, 0]);

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

    const maxDist = Math.max(...dist.slice(1));
    return maxDist === Infinity ? -1 : maxDist;
};