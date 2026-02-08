var findCheapestPrice = function(n, flights, src, dst, k) {
    const adj = Array(n).fill(null).map(() => []);
    for (const [u, v, w] of flights) {
        adj[u].push([v, w]);
    }

    const dist = Array(n).fill(Infinity);
    dist[src] = 0;

    const queue = [[src, 0, -1]]; // [node, cost, stops]

    while (queue.length > 0) {
        queue.sort((a, b) => a[1] - b[1]);
        const [u, cost, stops] = queue.shift();

        if (stops > k) continue;

        for (const [v, w] of adj[u]) {
            if (cost + w < dist[v]) {
                dist[v] = cost + w;
                queue.push([v, cost + w, stops + 1]);
            }
        }
    }

    return dist[dst] === Infinity ? -1 : dist[dst];
};