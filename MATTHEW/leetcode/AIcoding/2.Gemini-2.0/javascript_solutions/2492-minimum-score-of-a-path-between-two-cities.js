var minScore = function(n, roads) {
    const adj = new Array(n + 1).fill(null).map(() => []);
    for (const [u, v, w] of roads) {
        adj[u].push([v, w]);
        adj[v].push([u, w]);
    }

    const visited = new Array(n + 1).fill(false);
    let min = Infinity;

    const dfs = (node) => {
        visited[node] = true;
        for (const [neighbor, weight] of adj[node]) {
            min = Math.min(min, weight);
            if (!visited[neighbor]) {
                dfs(neighbor);
            }
        }
    };

    dfs(1);
    return min;
};