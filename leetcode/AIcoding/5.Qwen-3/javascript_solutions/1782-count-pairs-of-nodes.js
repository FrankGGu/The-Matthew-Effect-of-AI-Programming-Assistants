function countPairs(dist, n, x) {
    const MOD = 1000000007;
    const dp = new Array(n).fill(0).map(() => new Array(2).fill(0));
    const visited = new Array(n).fill(false);
    const adj = new Array(n).fill(0).map(() => []);

    for (let i = 0; i < dist.length; i++) {
        adj[dist[i][0]].push([dist[i][1], dist[i][2]]);
        adj[dist[i][1]].push([dist[i][0], dist[i][2]]);
    }

    function dfs(u, parent) {
        visited[u] = true;
        dp[u][0] = 1;
        dp[u][1] = 0;

        for (const [v, w] of adj[u]) {
            if (v === parent) continue;
            dfs(v, u);
            dp[u][0] = (dp[u][0] + dp[v][0]) % MOD;
            dp[u][1] = (dp[u][1] + dp[v][1]) % MOD;
        }

        for (const [v, w] of adj[u]) {
            if (v === parent) continue;
            dp[u][1] = (dp[u][1] + dp[v][0] * (dp[u][0] - dp[v][0])) % MOD;
        }
    }

    dfs(0, -1);

    return dp[0][1];
}