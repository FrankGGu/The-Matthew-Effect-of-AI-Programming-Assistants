function maximizeProfit(n, offers) {
    const dp = new Array(n).fill(0);
    const graph = new Array(n).fill(0).map(() => []);

    for (const [start, end, gold] of offers) {
        graph[start].push([end, gold]);
    }

    function dfs(node) {
        if (dp[node] !== 0) return dp[node];
        let maxProfit = 0;
        for (const [nextNode, gold] of graph[node]) {
            maxProfit = Math.max(maxProfit, dfs(nextNode) + gold);
        }
        dp[node] = maxProfit;
        return dp[node];
    }

    for (let i = 0; i < n; i++) {
        dfs(i);
    }

    return dp[0];
}