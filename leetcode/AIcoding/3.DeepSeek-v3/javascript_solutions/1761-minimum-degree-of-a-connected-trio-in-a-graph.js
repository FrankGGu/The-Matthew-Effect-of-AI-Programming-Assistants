var minTrioDegree = function(n, edges) {
    const adj = new Array(n + 1).fill().map(() => new Set());
    const degree = new Array(n + 1).fill(0);

    for (const [u, v] of edges) {
        adj[u].add(v);
        adj[v].add(u);
        degree[u]++;
        degree[v]++;
    }

    let minDegree = Infinity;

    for (let u = 1; u <= n; u++) {
        for (const v of adj[u]) {
            if (v > u) {
                for (const w of adj[v]) {
                    if (w > v && adj[u].has(w)) {
                        const trioDegree = degree[u] + degree[v] + degree[w] - 6;
                        if (trioDegree < minDegree) {
                            minDegree = trioDegree;
                        }
                    }
                }
            }
        }
    }

    return minDegree === Infinity ? -1 : minDegree;
};