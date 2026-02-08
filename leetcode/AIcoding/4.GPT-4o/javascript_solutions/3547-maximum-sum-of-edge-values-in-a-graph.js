var maximumSumEdgeValues = function(edges) {
    const n = edges.length + 1;
    const graph = Array.from({ length: n }, () => []);

    for (const [u, v, w] of edges) {
        graph[u].push({ node: v, weight: w });
        graph[v].push({ node: u, weight: w });
    }

    let maxSum = 0;

    for (let i = 0; i < n; i++) {
        let localMax = 0;
        for (const { weight } of graph[i]) {
            localMax += weight;
        }
        maxSum = Math.max(maxSum, localMax);
    }

    return maxSum;
};