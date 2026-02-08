function minimizeTotalPrice(n, edges, price, trips) {
    const graph = Array.from({ length: n }, () => []);
    const dp = new Array(n).fill(null).map(() => new Array(trips.length + 1).fill(-1));

    for (const [u, v] of edges) {
        graph[u].push(v);
        graph[v].push(u);
    }

    const dfs = (node, parent, tripCount) => {
        if (tripCount === 0) return 0;
        if (dp[node][tripCount] !== -1) return dp[node][tripCount];

        let totalCost = tripCount * price[node];
        for (const neighbor of graph[node]) {
            if (neighbor !== parent) {
                totalCost = Math.min(totalCost, dfs(neighbor, node, tripCount - 1));
            }
        }
        return dp[node][tripCount] = totalCost;
    };

    let minPrice = Infinity;
    for (let i = 0; i < n; i++) {
        minPrice = Math.min(minPrice, dfs(i, -1, trips));
    }

    return minPrice;
}