var maxStarSum = function(n, vals, edges, k) {
    let adj = new Array(n).fill(0).map(() => []);

    for (let i = 0; i < edges.length; i++) {
        const u = edges[i][0];
        const v = edges[i][1];
        adj[u].push(vals[v]);
        adj[v].push(vals[u]);
    }

    let maxStarSum = -Infinity;

    // Initialize maxStarSum with the maximum single node value.
    // This handles cases where k=0, no edges exist, or all neighbor values are negative.
    for (let i = 0; i < n; i++) {
        maxStarSum = Math.max(maxStarSum, vals[i]);
    }

    for (let i = 0; i < n; i++) {
        let currentSum = vals[i];

        let neighborValues = adj[i];
        neighborValues.sort((a, b) => b - a);

        let addedEdges = 0;
        for (let j = 0; j < neighborValues.length && addedEdges < k; j++) {
            if (neighborValues[j] > 0) {
                currentSum += neighborValues[j];
                addedEdges++;
            } else {
                break;
            }
        }

        maxStarSum = Math.max(maxStarSum, currentSum);
    }

    return maxStarSum;
};