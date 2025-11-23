var findTheEdges = function(n, edges, src, dst) {
    const adj = Array(n).fill(null).map(() => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    const dist = Array(n).fill(Infinity);
    dist[src] = 0;
    const q = [src];
    const parent = Array(n).fill(null).map(() => []);

    while (q.length > 0) {
        const u = q.shift();
        for (const v of adj[u]) {
            if (dist[v] > dist[u] + 1) {
                dist[v] = dist[u] + 1;
                q.push(v);
                parent[v] = [u];
            } else if (dist[v] === dist[u] + 1) {
                parent[v].push(u);
            }
        }
    }

    const shortestPathEdges = new Set();
    const dfs = (u) => {
        if (u === src) {
            return;
        }
        for (const p of parent[u]) {
            shortestPathEdges.add(JSON.stringify([Math.min(u, p), Math.max(u, p)]));
            dfs(p);
        }
    };

    dfs(dst);

    const result = [];
    for (const [u, v] of edges) {
        if (shortestPathEdges.has(JSON.stringify([Math.min(u, v), Math.max(u, v)]))) {
            result.push([u, v]);
        }
    }

    return result;
};