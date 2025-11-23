var minTime = function(n, edges, hasApple) {
    const adj = Array(n).fill(null).map(() => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    function dfs(node, parent) {
        let time = 0;
        for (const neighbor of adj[node]) {
            if (neighbor !== parent) {
                const childTime = dfs(neighbor, node);
                if (childTime > 0 || hasApple[neighbor]) {
                    time += 2 + childTime;
                }
            }
        }
        return time;
    }

    return dfs(0, -1);
};