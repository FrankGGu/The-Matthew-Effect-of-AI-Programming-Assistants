function networkDelayTime(times, n, k) {
    const graph = new Map();
    for (const [u, v, w] of times) {
        if (!graph.has(u)) graph.set(u, []);
        graph.get(u).push([v, w]);
    }

    const dist = new Array(n + 1).fill(Infinity);
    dist[k] = 0;
    const visited = new Array(n + 1).fill(false);

    for (let i = 0; i < n; i++) {
        let u = -1;
        for (let j = 1; j <= n; j++) {
            if (!visited[j] && (u === -1 || dist[j] < dist[u])) {
                u = j;
            }
        }
        if (u === -1) break;
        visited[u] = true;
        if (graph.has(u)) {
            for (const [v, w] of graph.get(u)) {
                if (dist[v] > dist[u] + w) {
                    dist[v] = dist[u] + w;
                }
            }
        }
    }

    let maxTime = 0;
    for (let i = 1; i <= n; i++) {
        if (dist[i] === Infinity) return -1;
        maxTime = Math.max(maxTime, dist[i]);
    }
    return maxTime;
}