var collectCoins = function(coins, edges) {
    const n = coins.length;
    const adj = Array(n).fill(null).map(() => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    const dp = Array(n).fill(null).map(() => Array(2).fill(0));

    function dfs(node, parent) {
        let take = Math.floor(coins[node] / 2);
        let notTake = coins[node];

        for (const neighbor of adj[node]) {
            if (neighbor !== parent) {
                dfs(neighbor, node);
                take += Math.max(dp[neighbor][1], dp[neighbor][0]);
                notTake += dp[neighbor][1];
            }
        }

        dp[node][0] = take;
        dp[node][1] = notTake;
    }

    dfs(0, -1);
    return Math.max(dp[0][0], dp[0][1]);
};