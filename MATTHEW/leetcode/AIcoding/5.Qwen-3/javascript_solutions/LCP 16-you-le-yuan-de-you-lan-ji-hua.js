function findMinCost(n, rides) {
    const graph = Array.from({ length: n + 1 }, () => []);
    for (const [u, v, c] of rides) {
        graph[u].push([v, c]);
    }

    const dist = Array(n + 1).fill(Infinity);
    dist[1] = 0;
    const visited = Array(n + 1).fill(false);

    const pq = [[0, 1]];
    while (pq.length > 0) {
        const [cost, u] = pq.shift();
        if (visited[u]) continue;
        visited[u] = true;
        for (const [v, c] of graph[u]) {
            if (dist[v] > dist[u] + c) {
                dist[v] = dist[u] + c;
                pq.push([dist[v], v]);
            }
        }
    }

    return dist[n];
}