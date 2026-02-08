var maxStarSum = function(vals, edges, k) {
    const graph = new Map();
    for (const [u, v] of edges) {
        if (!graph.has(u)) graph.set(u, []);
        if (!graph.has(v)) graph.set(v, []);
        graph.get(u).push(v);
        graph.get(v).push(u);
    }

    let maxSum = 0;
    for (let i = 0; i < vals.length; i++) {
        let sum = vals[i];
        const neighbors = graph.get(i) || [];
        const stars = neighbors
            .map(neighbor => vals[neighbor])
            .filter(value => value > 0)
            .sort((a, b) => b - a)
            .slice(0, k);

        sum += stars.reduce((a, b) => a + b, 0);
        maxSum = Math.max(maxSum, sum);
    }

    return maxSum;
};