var makeConnected = function(n, connections) {
    if (connections.length < n - 1) {
        return -1;
    }

    const adj = Array(n).fill(null).map(() => []);
    for (const [u, v] of connections) {
        adj[u].push(v);
        adj[v].push(u);
    }

    const visited = Array(n).fill(false);
    let components = 0;

    function dfs(node) {
        visited[node] = true;
        for (const neighbor of adj[node]) {
            if (!visited[neighbor]) {
                dfs(neighbor);
            }
        }
    }

    for (let i = 0; i < n; i++) {
        if (!visited[i]) {
            dfs(i);
            components++;
        }
    }

    return components - 1;
};