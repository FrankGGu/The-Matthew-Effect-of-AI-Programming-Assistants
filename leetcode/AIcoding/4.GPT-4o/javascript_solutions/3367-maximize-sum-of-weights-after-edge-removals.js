var maximumWeight = function(n, edges, k) {
    const graph = new Map();
    for (const [u, v, w] of edges) {
        if (!graph.has(u)) graph.set(u, []);
        if (!graph.has(v)) graph.set(v, []);
        graph.get(u).push([v, w]);
        graph.get(v).push([u, w]);
    }

    const dfs = (node, parent) => {
        let totalWeight = 0;
        const weights = [];
        for (const [neighbor, weight] of (graph.get(node) || [])) {
            if (neighbor !== parent) {
                const childWeight = dfs(neighbor, node);
                weights.push(childWeight);
                totalWeight += childWeight + weight;
            }
        }
        weights.sort((a, b) => b - a);
        for (let i = 0; i < k && i < weights.length; i++) {
            totalWeight -= weights[i];
        }
        return totalWeight;
    };

    return dfs(0, -1);
};