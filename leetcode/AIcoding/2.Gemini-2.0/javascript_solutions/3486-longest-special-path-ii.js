var longestSpecialPath = function(n, edges) {
    const adj = Array(n).fill(null).map(() => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    let maxLen = 0;

    function dfs(node, visited, path) {
        visited[node] = true;
        path.push(node);

        maxLen = Math.max(maxLen, path.length - 1);

        for (const neighbor of adj[node]) {
            if (!visited[neighbor]) {
                dfs(neighbor, { ...visited }, [...path]);
            }
        }
    }

    for (let i = 0; i < n; i++) {
        dfs(i, {}, []);
    }

    return maxLen;
};