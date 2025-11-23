var maximumProfit = function(n, edges, prices) {
    const graph = Array.from({ length: n }, () => []);
    const indegree = Array(n).fill(0);

    for (const [u, v] of edges) {
        graph[u].push(v);
        indegree[v]++;
    }

    const dp = Array(n).fill(0);
    const queue = [];

    for (let i = 0; i < n; i++) {
        dp[i] = prices[i];
        if (indegree[i] === 0) queue.push(i);
    }

    while (queue.length) {
        const u = queue.shift();

        for (const v of graph[u]) {
            dp[v] = Math.max(dp[v], dp[u] + prices[v]);
            indegree[v]--;
            if (indegree[v] === 0) queue.push(v);
        }
    }

    return Math.max(...dp);
};