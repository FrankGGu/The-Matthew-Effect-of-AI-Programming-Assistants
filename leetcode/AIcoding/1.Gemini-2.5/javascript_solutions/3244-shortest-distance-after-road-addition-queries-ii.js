var shortestDistanceAfterRoadAdditionQueriesII = function(n, initialEdges, queries) {
    const INF = Infinity;
    const dist = Array(n).fill(0).map(() => Array(n).fill(INF));

    for (let i = 0; i < n; i++) {
        dist[i][i] = 0;
    }

    for (const [u, v, w] of initialEdges) {
        const u0 = u - 1;
        const v0 = v - 1;
        dist[u0][v0] = Math.min(dist[u0][v0], w);
        dist[v0][u0] = Math.min(dist[v0][u0], w);
    }

    for (let k = 0; k < n; k++) {
        for (let i = 0; i < n; i++) {
            for (let j = 0; j < n; j++) {
                if (dist[i][k] !== INF && dist[k][j] !== INF) {
                    dist[i][j] = Math.min(dist[i][j], dist[i][k] + dist[k][j]);
                }
            }
        }
    }

    const results = [];

    for (const query of queries) {
        const type = query[0];
        if (type === 1) {
            const u = query[1] - 1;
            const v = query[2] - 1;
            const w = query[3];

            dist[u][v] = Math.min(dist[u][v], w);
            dist[v][u] = Math.min(dist[v][u], w);

            for (let i = 0; i < n; i++) {
                for (let j = 0; j < n; j++) {
                    if (dist[i][u] !== INF && dist[u][v] !== INF && dist[v][j] !== INF) {
                        dist[i][j] = Math.min(dist[i][j], dist[i][u] + dist[u][v] + dist[v][j]);
                    }
                    if (dist[i][v] !== INF && dist[v][u] !== INF && dist[u][j] !== INF) {
                        dist[i][j] = Math.min(dist[i][j], dist[i][v] + dist[v][u] + dist[u][j]);
                    }
                }
            }

        } else if (type === 2) {
            const s = query[1] - 1;
            const t = query[2] - 1;
            const shortest = dist[s][t];
            results.push(shortest === INF ? -1 : shortest);
        }
    }

    return results;
};