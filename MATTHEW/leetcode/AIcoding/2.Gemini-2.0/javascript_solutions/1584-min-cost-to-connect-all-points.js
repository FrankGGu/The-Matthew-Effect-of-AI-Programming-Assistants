var minCostConnectPoints = function(points) {
    const n = points.length;
    const adj = Array(n).fill(null).map(() => []);

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            const dist = Math.abs(points[i][0] - points[j][0]) + Math.abs(points[i][1] - points[j][1]);
            adj[i].push([j, dist]);
            adj[j].push([i, dist]);
        }
    }

    const minCost = Array(n).fill(Infinity);
    minCost[0] = 0;
    const visited = Array(n).fill(false);
    let totalCost = 0;

    for (let count = 0; count < n; count++) {
        let u = -1;
        for (let v = 0; v < n; v++) {
            if (!visited[v] && (u === -1 || minCost[v] < minCost[u])) {
                u = v;
            }
        }

        visited[u] = true;
        totalCost += minCost[u];

        for (const [v, weight] of adj[u]) {
            if (!visited[v] && weight < minCost[v]) {
                minCost[v] = weight;
            }
        }
    }

    return totalCost;
};