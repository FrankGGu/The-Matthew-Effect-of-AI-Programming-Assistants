var minReorder = function(n, connections) {
    const graph = Array.from({ length: n }, () => []);

    for (const [u, v] of connections) {
        graph[u].push([v, 1]);
        graph[v].push([u, 0]);
    }

    let result = 0;
    const visited = new Set();

    const dfs = (node) => {
        visited.add(node);
        for (const [neighbor, direction] of graph[node]) {
            if (!visited.has(neighbor)) {
                result += direction;
                dfs(neighbor);
            }
        }
    };

    dfs(0);
    return result;
};