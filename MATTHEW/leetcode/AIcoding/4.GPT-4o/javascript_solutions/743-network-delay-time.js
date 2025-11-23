var networkDelayTime = function(times, N, K) {
    const graph = new Map();
    for (const [u, v, w] of times) {
        if (!graph.has(u)) graph.set(u, []);
        graph.get(u).push([v, w]);
    }

    const dist = new Array(N + 1).fill(Infinity);
    dist[K] = 0;

    const minHeap = new MinPriorityQueue();
    minHeap.enqueue([0, K]);

    while (minHeap.size() > 0) {
        const [time, node] = minHeap.dequeue().element;
        if (time > dist[node]) continue;

        for (const [neighbor, weight] of (graph.get(node) || [])) {
            const newTime = time + weight;
            if (newTime < dist[neighbor]) {
                dist[neighbor] = newTime;
                minHeap.enqueue([newTime, neighbor]);
            }
        }
    }

    const maxTime = Math.max(...dist.slice(1));
    return maxTime === Infinity ? -1 : maxTime;
};