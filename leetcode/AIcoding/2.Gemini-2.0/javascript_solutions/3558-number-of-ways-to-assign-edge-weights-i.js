var waysToAssignEdgeWeights = function(n, edges) {
    const adj = Array(n).fill(null).map(() => []);
    const degree = Array(n).fill(0);
    for (const [u, v] of edges) {
        adj[u - 1].push(v - 1);
        adj[v - 1].push(u - 1);
        degree[u - 1]++;
        degree[v - 1]++;
    }

    let hasEvenDegree = false;
    for (let i = 0; i < n; i++) {
        if (degree[i] % 2 === 0) {
            hasEvenDegree = true;
            break;
        }
    }

    let min = 1;
    if (hasEvenDegree) {
        min = 0;
    }

    let max = edges.length;
    for (let i = 0; i < n; i++) {
        if (adj[i].length > 1) {
            return [min, max];
        }
    }
    return [min, max];
};