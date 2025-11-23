var findTheCity = function(n, edges, distanceThreshold) {
    const dist = Array(n).fill(null).map(() => Array(n).fill(Infinity));

    for (let i = 0; i < n; i++) {
        dist[i][i] = 0;
    }

    for (const [u, v, w] of edges) {
        dist[u][v] = w;
        dist[v][u] = w;
    }

    for (let k = 0; k < n; k++) {
        for (let i = 0; i < n; i++) {
            for (let j = 0; j < n; j++) {
                dist[i][j] = Math.min(dist[i][j], dist[i][k] + dist[k][j]);
            }
        }
    }

    let minReachable = n + 1;
    let city = -1;

    for (let i = 0; i < n; i++) {
        let reachable = 0;
        for (let j = 0; j < n; j++) {
            if (i !== j && dist[i][j] <= distanceThreshold) {
                reachable++;
            }
        }

        if (reachable <= minReachable) {
            minReachable = reachable;
            city = i;
        }
    }

    return city;
};