var countSubTrees = function(n, edges, labels) {
    const adj = Array(n).fill(null).map(() => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    const result = Array(n).fill(0);
    const visited = Array(n).fill(false);

    function dfs(node) {
        visited[node] = true;
        const counts = Array(26).fill(0);
        counts[labels.charCodeAt(node) - 'a'.charCodeAt(0)] = 1;

        for (const neighbor of adj[node]) {
            if (!visited[neighbor]) {
                const neighborCounts = dfs(neighbor);
                for (let i = 0; i < 26; i++) {
                    counts[i] += neighborCounts[i];
                }
            }
        }

        result[node] = counts[labels.charCodeAt(node) - 'a'.charCodeAt(0)];
        return counts;
    }

    dfs(0);
    return result;
};