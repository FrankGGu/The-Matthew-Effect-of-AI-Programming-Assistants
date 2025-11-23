var shortestDistanceAfterRoadAdditionQueries = function(n, queries) {
    const dist = Array(n).fill(0).map(() => Array(n).fill(Infinity));

    for (let i = 0; i < n; i++) {
        dist[i][i] = 0;
    }

    const results = [];

    for (const query of queries) {
        const u = query[0];
        const v = query[1];
        const w = query[2];
        const s = query[3];
        const t = query[4];

        // Add the new road (u, v) with weight w
        // Update dist[u][v] and dist[v][u] with the new road's weight
        // This considers the direct path provided by the new road
        dist[u][v] = Math.min(dist[u][v], w);
        dist[v][u] = Math.min(dist[v][u], w);

        // Update all-pairs shortest paths using the new edge (u, v)
        // This is an incremental update for Floyd-Warshall
        // For every pair (i, j), consider paths that might now use the new edge (u, v)
        for (let i = 0; i < n; i++) {
            for (let j = 0; j < n; j++) {
                // Path i -> ... -> u -> v -> ... -> j
                if (dist[i][u] !== Infinity && dist[u][v] !== Infinity && dist[v][j] !== Infinity) {
                    dist[i][j] = Math.min(dist[i][j], dist[i][u] + dist[u][v] + dist[v][j]);
                }
                // Path i -> ... -> v -> u -> ... -> j
                if (dist[i][v] !== Infinity && dist[v][u] !== Infinity && dist[u][j] !== Infinity) {
                    dist[i][j] = Math.min(dist[i][j], dist[i][v] + dist[v][u] + dist[u][j]);
                }
            }
        }

        // After updating all-pairs shortest paths, record the result for the current query
        const shortestPath = dist[s][t];
        results.push(shortestPath === Infinity ? -1 : shortestPath);
    }

    return results;
};