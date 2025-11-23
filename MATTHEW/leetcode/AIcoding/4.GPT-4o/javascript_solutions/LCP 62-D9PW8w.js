var findTheCity = function(n, edges, distanceThreshold) {
    const graph = Array.from({ length: n }, () => new Array(n).fill(Infinity));
    for (let i = 0; i < n; i++) {
        graph[i][i] = 0;
    }
    for (const [u, v, w] of edges) {
        graph[u][v] = w;
        graph[v][u] = w;
    }

    for (let k = 0; k < n; k++) {
        for (let i = 0; i < n; i++) {
            for (let j = 0; j < n; j++) {
                graph[i][j] = Math.min(graph[i][j], graph[i][k] + graph[k][j]);
            }
        }
    }

    let minCity = -1;
    let minCount = Infinity;

    for (let i = 0; i < n; i++) {
        let count = 0;
        for (let j = 0; j < n; j++) {
            if (graph[i][j] <= distanceThreshold) {
                count++;
            }
        }
        if (count <= minCount) {
            minCount = count;
            minCity = i;
        }
    }

    return minCity;
};