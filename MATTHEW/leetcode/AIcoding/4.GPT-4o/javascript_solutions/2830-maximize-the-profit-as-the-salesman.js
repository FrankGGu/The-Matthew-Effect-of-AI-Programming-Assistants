var maximizeProfit = function(n, edges, prices) {
    const graph = new Map();
    for (const [u, v] of edges) {
        if (!graph.has(u)) graph.set(u, []);
        if (!graph.has(v)) graph.set(v, []);
        graph.get(u).push(v);
        graph.get(v).push(u);
    }

    const dp = Array(n + 1).fill(0);
    const visited = Array(n + 1).fill(false);

    const dfs = (node) => {
        visited[node] = true;
        let total = prices[node - 1];
        for (const neighbor of graph.get(node) || []) {
            if (!visited[neighbor]) {
                total += dfs(neighbor);
            }
        }
        dp[node] = Math.max(dp[node], total);
        return total;
    };

    for (let i = 1; i <= n; i++) {
        if (!visited[i]) {
            dfs(i);
        }
    }

    return Math.max(...dp);
};