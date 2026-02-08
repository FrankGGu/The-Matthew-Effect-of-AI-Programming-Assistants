var minimumTotalPrice = function(n, edges, price, trips) {
    const adj = Array(n).fill(null).map(() => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    const counts = Array(n).fill(0);
    for (const [start, end] of trips) {
        const path = [];
        const visited = Array(n).fill(false);

        function dfs(node, target) {
            path.push(node);
            visited[node] = true;

            if (node === target) {
                return true;
            }

            for (const neighbor of adj[node]) {
                if (!visited[neighbor]) {
                    if (dfs(neighbor, target)) {
                        return true;
                    }
                }
            }

            path.pop();
            return false;
        }

        dfs(start, end);
        for (const node of path) {
            counts[node]++;
        }
    }

    const dp = Array(n).fill(null).map(() => [0, 0]);

    function dfsDP(node, parent) {
        dp[node][0] = price[node] * counts[node];
        dp[node][1] = (price[node] / 2) * counts[node];

        for (const neighbor of adj[node]) {
            if (neighbor !== parent) {
                dfsDP(neighbor, node);
                dp[node][0] += Math.min(dp[neighbor][0], dp[neighbor][1]);
                dp[node][1] += dp[neighbor][0];
            }
        }
    }

    dfsDP(0, -1);
    return Math.min(dp[0][0], dp[0][1]);
};