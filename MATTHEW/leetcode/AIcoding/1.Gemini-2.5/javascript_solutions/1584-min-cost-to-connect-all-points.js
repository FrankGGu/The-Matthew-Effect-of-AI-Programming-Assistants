var minCostConnectPoints = function(points) {
    const n = points.length;
    let minCost = 0;
    const minDistances = new Array(n).fill(Infinity);
    const visited = new Array(n).fill(false);

    minDistances[0] = 0; // Start Prim's algorithm from the first point

    for (let i = 0; i < n; i++) {
        let u = -1;
        let currentMinDist = Infinity;

        // Find the unvisited point with the minimum distance to the current MST
        for (let v = 0; v < n; v++) {
            if (!visited[v] && minDistances[v] < currentMinDist) {
                currentMinDist = minDistances[v];
                u = v;
            }
        }

        if (u === -1) {
            // Should not happen if the graph is connected (which it always is for this problem)
            break;
        }

        minCost += currentMinDist;
        visited[u] = true;

        // Update distances for adjacent unvisited points
        for (let v = 0; v < n; v++) {
            if (!visited[v]) {
                const dist_uv = Math.abs(points[u][0] - points[v][0]) + Math.abs(points[u][1] - points[v][1]);
                minDistances[v] = Math.min(minDistances[v], dist_uv);
            }
        }
    }

    return minCost;
};