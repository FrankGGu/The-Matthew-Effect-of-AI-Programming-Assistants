var findTheCity = function(n, edges, threshold) {
    const dist = Array(n).fill(0).map(() => Array(n).fill(Infinity));

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
                if (dist[i][k] !== Infinity && dist[k][j] !== Infinity) {
                    dist[i][j] = Math.min(dist[i][j], dist[i][k] + dist[k][j]);
                }
            }
        }
    }

    let minReachableCities = n + 1;
    let cityWithSmallestNeighbors = -1;

    for (let i = 0; i < n; i++) {
        let currentReachableCount = 0;
        for (let j = 0; j < n; j++) {
            if (i === j) continue;
            if (dist[i][j] <= threshold) {
                currentReachableCount++;
            }
        }

        if (currentReachableCount < minReachableCities) {
            minReachableCities = currentReachableCount;
            cityWithSmallestNeighbors = i;
        } else if (currentReachableCount === minReachableCities) {
            cityWithSmallestNeighbors = i;
        }
    }

    return cityWithSmallestNeighbors;
};