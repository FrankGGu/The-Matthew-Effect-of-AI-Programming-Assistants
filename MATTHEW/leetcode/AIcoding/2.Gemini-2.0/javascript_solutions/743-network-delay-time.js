var networkDelayTime = function(times, n, k) {
    const graph = {};
    for (let i = 1; i <= n; i++) {
        graph[i] = [];
    }
    for (const [u, v, w] of times) {
        graph[u].push([v, w]);
    }

    const dist = {};
    for (let i = 1; i <= n; i++) {
        dist[i] = Infinity;
    }
    dist[k] = 0;

    const visited = new Set();

    while (visited.size < n) {
        let u = null;
        let minDist = Infinity;
        for (let i = 1; i <= n; i++) {
            if (!visited.has(i) && dist[i] < minDist) {
                minDist = dist[i];
                u = i;
            }
        }

        if (u === null) break;

        visited.add(u);

        for (const [v, w] of graph[u]) {
            dist[v] = Math.min(dist[v], dist[u] + w);
        }
    }

    let maxDelay = 0;
    for (let i = 1; i <= n; i++) {
        if (dist[i] === Infinity) return -1;
        maxDelay = Math.max(maxDelay, dist[i]);
    }

    return maxDelay;
};