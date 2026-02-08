var minimumTime = function(n, edges, disappear) {
    const adj = Array.from({ length: n }, () => []);
    for (const [u, v, time] of edges) {
        adj[u].push([v, time]);
        adj[v].push([u, time]);
    }

    const dist = new Array(n).fill(Infinity);
    dist[0] = 0;
    const heap = new MinPriorityQueue({ priority: (x) => x[1] });
    heap.enqueue([0, 0]);

    while (!heap.isEmpty()) {
        const [u, currentDist] = heap.dequeue().element;
        if (currentDist > dist[u]) continue;

        for (const [v, time] of adj[u]) {
            const newDist = currentDist + time;
            if (newDist < dist[v] && newDist < disappear[v]) {
                dist[v] = newDist;
                heap.enqueue([v, newDist]);
            }
        }
    }

    const result = [];
    for (let i = 0; i < n; i++) {
        result.push(dist[i] <= disappear[i] ? dist[i] : -1);
    }
    return result;
};