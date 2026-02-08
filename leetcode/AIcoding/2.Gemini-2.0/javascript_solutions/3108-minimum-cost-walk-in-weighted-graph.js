var minCost = function(n, edges, cost) {
    const adj = Array(n).fill(null).map(() => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    let minCost1 = Infinity;

    for (let i = 0; i < n; i++) {
        const neighbors = adj[i];
        if (neighbors.length < 2) continue;

        const costs = [];
        for (const neighbor of neighbors) {
            costs.push(cost[neighbor]);
        }

        costs.sort((a, b) => a - b);

        if (costs.length >= 2) {
            minCost1 = Math.min(minCost1, costs[0] + costs[1] + cost[i]);
        }
    }

    return minCost1 === Infinity ? -1 : minCost1;
};