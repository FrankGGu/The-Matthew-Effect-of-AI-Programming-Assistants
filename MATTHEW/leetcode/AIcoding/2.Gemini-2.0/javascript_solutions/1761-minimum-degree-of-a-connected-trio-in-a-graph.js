var minTrioDegree = function(n, edges) {
    const adj = Array(n + 1).fill(null).map(() => Array(n + 1).fill(false));
    const degree = Array(n + 1).fill(0);

    for (const [u, v] of edges) {
        adj[u][v] = true;
        adj[v][u] = true;
        degree[u]++;
        degree[v]++;
    }

    let minDegree = Infinity;

    for (let i = 1; i <= n; i++) {
        for (let j = i + 1; j <= n; j++) {
            if (adj[i][j]) {
                for (let k = j + 1; k <= n; k++) {
                    if (adj[i][k] && adj[j][k]) {
                        minDegree = Math.min(minDegree, degree[i] + degree[j] + degree[k] - 6);
                    }
                }
            }
        }
    }

    return minDegree === Infinity ? -1 : minDegree;
};