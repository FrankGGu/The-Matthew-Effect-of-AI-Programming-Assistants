var maxStarSum = function(vals, edges, k) {
    const n = vals.length;
    const adj = Array(n).fill(null).map(() => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    let maxSum = -Infinity;
    for (let i = 0; i < n; i++) {
        let neighbors = adj[i].map(neighbor => vals[neighbor]);
        neighbors.sort((a, b) => b - a);
        let currentSum = vals[i];
        for (let j = 0; j < Math.min(k, neighbors.length); j++) {
            if (neighbors[j] > 0) {
                currentSum += neighbors[j];
            } else {
                break;
            }
        }
        maxSum = Math.max(maxSum, currentSum);
    }

    return maxSum;
};