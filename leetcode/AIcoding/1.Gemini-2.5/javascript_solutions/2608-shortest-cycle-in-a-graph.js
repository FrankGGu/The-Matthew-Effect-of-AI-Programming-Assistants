var shortestCycle = function(n, edges) {
    const adj = Array(n).fill(0).map(() => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    let minCycle = Infinity;

    for (let i = 0; i < n; i++) {
        const dist = Array(n).fill(Infinity);
        const parent = Array(n).fill(-1);
        const q = [];

        q.push(i);
        dist[i] = 0;

        let head = 0; 

        while (head < q.length) {
            const u = q[head++];

            for (const v of adj[u]) {
                if (dist[v] === Infinity) { 
                    dist[v] = dist[u] + 1;
                    parent[v] = u;
                    q.push(v);
                } else if (v !== parent[u]) { 
                    const cycleLength = dist[u] + dist[v] + 1;
                    minCycle = Math.min(minCycle, cycleLength);
                }
            }
        }
    }

    return minCycle === Infinity ? -1 : minCycle;
};