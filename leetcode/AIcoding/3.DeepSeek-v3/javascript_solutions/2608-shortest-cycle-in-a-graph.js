var findShortestCycle = function(n, edges) {
    const adj = Array.from({ length: n }, () => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    let minCycle = Infinity;

    for (let i = 0; i < n; i++) {
        const distance = Array(n).fill(-1);
        const parent = Array(n).fill(-1);
        const queue = [i];
        distance[i] = 0;

        while (queue.length > 0) {
            const u = queue.shift();
            for (const v of adj[u]) {
                if (distance[v] === -1) {
                    distance[v] = distance[u] + 1;
                    parent[v] = u;
                    queue.push(v);
                } else if (parent[u] !== v && parent[v] !== u) {
                    const cycleLength = distance[u] + distance[v] + 1;
                    minCycle = Math.min(minCycle, cycleLength);
                }
            }
        }
    }

    return minCycle === Infinity ? -1 : minCycle;
};