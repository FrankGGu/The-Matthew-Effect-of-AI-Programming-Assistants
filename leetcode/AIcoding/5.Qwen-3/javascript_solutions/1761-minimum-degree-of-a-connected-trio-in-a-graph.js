function minTrio(n, edges) {
    const adj = Array.from({ length: n + 1 }, () => new Set());
    for (const [u, v] of edges) {
        adj[u].add(v);
        adj[v].add(u);
    }

    let minDegree = Infinity;

    for (let i = 1; i <= n; i++) {
        for (let j of adj[i]) {
            if (j > i) {
                for (let k of adj[j]) {
                    if (k > j && adj[i].has(k)) {
                        const degree = adj[i].size + adj[j].size + adj[k].size - 3;
                        if (degree < minDegree) {
                            minDegree = degree;
                        }
                    }
                }
            }
        }
    }

    return minDegree === Infinity ? -1 : minDegree;
}