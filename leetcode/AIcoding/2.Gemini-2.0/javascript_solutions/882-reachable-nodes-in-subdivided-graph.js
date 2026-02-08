var reachableNodes = function(edges, maxMoves, n) {
    const adj = Array(n).fill(null).map(() => []);
    for (const [u, v, w] of edges) {
        adj[u].push([v, w]);
        adj[v].push([u, w]);
    }

    const dist = Array(n).fill(Infinity);
    dist[0] = 0;
    const pq = [[0, 0]]; // [distance, node]

    while (pq.length > 0) {
        pq.sort((a, b) => a[0] - b[0]);
        const [d, u] = pq.shift();

        if (d > dist[u]) continue;

        for (const [v, w] of adj[u]) {
            if (dist[u] + w + 1 < dist[v]) {
                dist[v] = dist[u] + w + 1;
                pq.push([dist[v], v]);
            }
        }
    }

    let reachable = 0;
    for (let i = 0; i < n; i++) {
        if (dist[i] <= maxMoves) {
            reachable++;
        }
    }

    let addedNodes = 0;
    for (const [u, v, w] of edges) {
        const reachableU = Math.max(0, maxMoves - dist[u]);
        const reachableV = Math.max(0, maxMoves - dist[v]);
        addedNodes += Math.min(w, reachableU + reachableV);
    }

    return reachable + addedNodes;
};