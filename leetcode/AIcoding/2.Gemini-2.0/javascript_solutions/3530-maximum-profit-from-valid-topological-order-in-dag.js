var maximumProfit = function(n, edges, cost) {
    const adj = Array(n).fill(null).map(() => []);
    const indegree = Array(n).fill(0);

    for (const [u, v] of edges) {
        adj[u].push(v);
        indegree[v]++;
    }

    const queue = [];
    for (let i = 0; i < n; i++) {
        if (indegree[i] === 0) {
            queue.push(i);
        }
    }

    const dp = Array(n).fill(-Infinity);
    for (let i = 0; i < n; i++) {
        dp[i] = -cost[i];
    }

    const visited = Array(n).fill(false);

    while (queue.length > 0) {
        const u = queue.shift();
        visited[u] = true;

        for (const v of adj[u]) {
            dp[v] = Math.max(dp[v], dp[u] + cost[v]);
            indegree[v]--;
            if (indegree[v] === 0) {
                queue.push(v);
            }
        }
    }

    let ans = -1;
    for (let i = 0; i < n; i++) {
        if (!visited[i] && indegree[i] > 0) return -1;
        ans = Math.max(ans, dp[i]);
    }

    return ans;
};