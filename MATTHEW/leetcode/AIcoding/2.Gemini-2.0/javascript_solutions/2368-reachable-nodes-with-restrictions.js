var reachableNodes = function(n, edges, restricted) {
    const adj = new Array(n).fill(null).map(() => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    const restrictedSet = new Set(restricted);
    const visited = new Array(n).fill(false);
    let count = 0;

    function dfs(node) {
        if (visited[node] || restrictedSet.has(node)) {
            return;
        }

        visited[node] = true;
        count++;

        for (const neighbor of adj[node]) {
            dfs(neighbor);
        }
    }

    dfs(0);
    return count;
};