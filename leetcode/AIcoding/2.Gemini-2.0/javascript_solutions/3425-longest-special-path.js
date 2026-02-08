var longestPath = function(n, edges, values) {
    const adj = Array(n).fill(null).map(() => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    let maxLen = 0;

    function dfs(node, visited, currentPath) {
        visited[node] = true;
        currentPath.push(values[node]);

        maxLen = Math.max(maxLen, currentPath.length);

        for (const neighbor of adj[node]) {
            if (!visited[neighbor]) {
                dfs(neighbor, { ...visited }, [...currentPath]);
            }
        }
    }

    for (let i = 0; i < n; i++) {
        dfs(i, {}, []);
    }

    return maxLen;
};