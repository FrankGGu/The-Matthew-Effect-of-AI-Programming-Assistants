var minTime = function(n, edges, hasApple) {
    const adj = new Array(n).fill(0).map(() => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    function dfs(u, p) {
        let currentTime = 0;
        for (const v of adj[u]) {
            if (v === p) {
                continue;
            }
            const timeFromChild = dfs(v, u);
            if (timeFromChild > 0 || hasApple[v]) {
                currentTime += (timeFromChild + 2);
            }
        }
        return currentTime;
    }

    return dfs(0, -1);
};