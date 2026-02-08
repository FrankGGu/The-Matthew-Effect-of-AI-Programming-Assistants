var networkBecomesIdle = function(edges, patience) {
    const n = patience.length;
    const adj = new Array(n).fill().map(() => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    const distance = new Array(n).fill(Infinity);
    distance[0] = 0;
    const queue = [0];

    while (queue.length > 0) {
        const u = queue.shift();
        for (const v of adj[u]) {
            if (distance[v] === Infinity) {
                distance[v] = distance[u] + 1;
                queue.push(v);
            }
        }
    }

    let maxTime = 0;
    for (let i = 1; i < n; i++) {
        const roundTripTime = 2 * distance[i];
        const lastSend = Math.floor((roundTripTime - 1) / patience[i]) * patience[i];
        const totalTime = lastSend + roundTripTime;
        if (totalTime > maxTime) {
            maxTime = totalTime;
        }
    }

    return maxTime + 1;
};