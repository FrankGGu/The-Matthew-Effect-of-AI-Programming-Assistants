function minCost(paths) {
    const n = paths.length;
    const graph = Array.from({ length: n }, () => []);

    for (const [u, v, cost] of paths) {
        graph[u].push([v, cost]);
        graph[v].push([u, cost]);
    }

    const dist = Array(n).fill(Infinity);
    dist[0] = 0;
    const pq = [[0, 0]]; // [cost, node]

    while (pq.length) {
        const [currentCost, node] = pq.shift();

        if (currentCost > dist[node]) continue;

        for (const [neighbor, cost] of graph[node]) {
            const newCost = currentCost + cost;
            if (newCost < dist[neighbor]) {
                dist[neighbor] = newCost;
                pq.push([newCost, neighbor]);
            }
        }
    }

    return dist[n - 1] === Infinity ? -1 : dist[n - 1];
}