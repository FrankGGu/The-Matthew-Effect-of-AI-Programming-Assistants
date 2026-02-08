var findShortestCycle = function(n, edges) {
    const adj = Array(n).fill(null).map(() => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    let minCycle = Infinity;

    for (let startNode = 0; startNode < n; startNode++) {
        const dist = Array(n).fill(Infinity);
        const parent = Array(n).fill(-1);
        const queue = [];

        dist[startNode] = 0;
        queue.push(startNode);

        while (queue.length > 0) {
            const u = queue.shift();

            for (const v of adj[u]) {
                if (dist[v] === Infinity) {
                    dist[v] = dist[u] + 1;
                    parent[v] = u;
                    queue.push(v);
                } else if (parent[u] !== v && parent[v] !== u) {
                    minCycle = Math.min(minCycle, dist[u] + dist[v] + 1);
                }
            }
        }
    }

    return minCycle === Infinity ? -1 : minCycle;
};