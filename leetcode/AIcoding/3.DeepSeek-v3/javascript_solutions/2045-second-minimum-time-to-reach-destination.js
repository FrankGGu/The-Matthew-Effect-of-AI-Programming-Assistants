var secondMinimum = function(n, edges, time, change) {
    const adj = new Array(n + 1).fill().map(() => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    const dist = new Array(n + 1).fill().map(() => [Infinity, Infinity]);
    dist[1][0] = 0;
    const queue = [[1, 0]];

    while (queue.length) {
        const [node, d] = queue.shift();
        for (const neighbor of adj[node]) {
            if (d + 1 < dist[neighbor][0]) {
                dist[neighbor][0] = d + 1;
                queue.push([neighbor, d + 1]);
            } else if (d + 1 > dist[neighbor][0] && d + 1 < dist[neighbor][1]) {
                dist[neighbor][1] = d + 1;
                queue.push([neighbor, d + 1]);
            }
        }
    }

    let totalTime = 0;
    for (let i = 0; i < dist[n][1]; i++) {
        totalTime += time;
        if (i < dist[n][1] - 1) {
            const cycles = Math.floor(totalTime / change);
            if (cycles % 2 === 1) {
                totalTime = (cycles + 1) * change;
            }
        }
    }
    return totalTime;
};