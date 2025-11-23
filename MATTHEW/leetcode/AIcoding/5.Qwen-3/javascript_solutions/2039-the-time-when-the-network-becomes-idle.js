function networkBecomesIdle(edges, nodeCount, patience) {
    const graph = Array.from({ length: nodeCount }, () => []);
    for (const [u, v] of edges) {
        graph[u].push(v);
        graph[v].push(u);
    }

    const dist = Array(nodeCount).fill(-1);
    const queue = [0];
    dist[0] = 0;

    while (queue.length) {
        const u = queue.shift();
        for (const v of graph[u]) {
            if (dist[v] === -1) {
                dist[v] = dist[u] + 1;
                queue.push(v);
            }
        }
    }

    let maxTime = 0;
    for (let i = 1; i < nodeCount; i++) {
        const d = dist[i];
        const time = (Math.floor((d * 2) / patience[i]) * patience[i]) + d * 2;
        maxTime = Math.max(maxTime, time);
    }

    return maxTime;
}