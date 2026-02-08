var shortestDistance = function(n, edges, queries) {
    const dist = Array(n).fill(null).map(() => Array(n).fill(Infinity));
    for (let i = 0; i < n; i++) {
        dist[i][i] = 0;
    }
    for (const [u, v, w] of edges) {
        dist[u][v] = w;
        dist[v][u] = w;
    }

    const addedEdges = new Set();
    const result = [];

    for (const [u, v] of queries) {
        let minDistance = dist[u][v];

        for (let k = 0; k < n; k++) {
            for (let i = 0; i < n; i++) {
                for (let j = 0; j < n; j++) {
                    dist[i][j] = Math.min(dist[i][j], dist[i][k] + dist[k][j]);
                }
            }
        }

        minDistance = dist[u][v];
        if (minDistance === Infinity) {
            result.push(-1);
        } else {
            result.push(minDistance);
        }
    }

    return result;
};