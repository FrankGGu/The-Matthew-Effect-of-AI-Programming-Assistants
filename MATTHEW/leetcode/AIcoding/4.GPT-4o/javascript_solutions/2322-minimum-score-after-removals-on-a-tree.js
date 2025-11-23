var minimumScore = function(n, edges) {
    const graph = Array.from({ length: n + 1 }, () => []);
    for (const [u, v, w] of edges) {
        graph[u].push([v, w]);
        graph[v].push([u, w]);
    }

    const visited = new Set();
    let minScore = Infinity;

    const dfs = (node) => {
        visited.add(node);
        for (const [neighbor, weight] of graph[node]) {
            if (!visited.has(neighbor)) {
                minScore = Math.min(minScore, weight);
                dfs(neighbor);
            }
        }
    };

    dfs(1);
    return minScore;
};