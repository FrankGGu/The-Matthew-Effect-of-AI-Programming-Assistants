function findTheCity(n, edges, distanceThreshold) {
    const dist = Array.from({ length: n }, () => Array(n).fill(Infinity));

    for (let i = 0; i < n; i++) {
        dist[i][i] = 0;
    }

    for (const [u, v, w] of edges) {
        dist[u][v] = Math.min(dist[u][v], w);
        dist[v][u] = Math.min(dist[v][u], w);
    }

    for (let k = 0; k < n; k++) {
        for (let i = 0; i < n; i++) {
            for (let j = 0; j < n; j++) {
                if (dist[i][k] + dist[k][j] < dist[i][j]) {
                    dist[i][j] = dist[i][k] + dist[k][j];
                }
            }
        }
    }

    let minCities = n;
    let resultCity = -1;

    for (let i = 0; i < n; i++) {
        let count = 0;
        for (let j = 0; j < n; j++) {
            if (i !== j && dist[i][j] <= distanceThreshold) {
                count++;
            }
        }
        if (count < minCities) {
            minCities = count;
            resultCity = i;
        } else if (count === minCities && i < resultCity) {
            resultCity = i;
        }
    }

    return resultCity;
}