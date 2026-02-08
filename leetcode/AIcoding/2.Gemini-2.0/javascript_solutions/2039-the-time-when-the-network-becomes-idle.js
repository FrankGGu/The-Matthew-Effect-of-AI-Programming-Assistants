var networkBecomesIdle = function(edges, patience) {
    const n = patience.length;
    const adj = Array(n).fill(null).map(() => []);

    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    const dist = Array(n).fill(Infinity);
    dist[0] = 0;
    const queue = [0];

    while (queue.length > 0) {
        const u = queue.shift();
        for (const v of adj[u]) {
            if (dist[v] === Infinity) {
                dist[v] = dist[u] + 1;
                queue.push(v);
            }
        }
    }

    let maxTime = 0;
    for (let i = 1; i < n; i++) {
        const travelTime = dist[i] * 2;
        const lastSendTime = Math.floor((travelTime - 1) / patience[i]) * patience[i];
        const returnTime = lastSendTime + travelTime;
        maxTime = Math.max(maxTime, returnTime);
    }

    return maxTime + 1;
};