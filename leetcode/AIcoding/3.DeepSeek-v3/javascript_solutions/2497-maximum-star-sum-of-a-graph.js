var maxStarSum = function(vals, edges, k) {
    const n = vals.length;
    const graph = Array.from({ length: n }, () => []);

    for (const [u, v] of edges) {
        if (vals[v] > 0) graph[u].push(vals[v]);
        if (vals[u] > 0) graph[v].push(vals[u]);
    }

    let maxSum = -Infinity;

    for (let i = 0; i < n; i++) {
        graph[i].sort((a, b) => b - a);
        let sum = vals[i];
        for (let j = 0; j < Math.min(k, graph[i].length); j++) {
            sum += graph[i][j];
        }
        maxSum = Math.max(maxSum, sum);
    }

    return maxSum;
};