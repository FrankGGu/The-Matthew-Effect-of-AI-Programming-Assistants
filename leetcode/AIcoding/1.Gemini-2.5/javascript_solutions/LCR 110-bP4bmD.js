var allPathsSourceTarget = function(graph) {
    const n = graph.length;
    const result = [];
    const currentPath = [];

    function dfs(node) {
        currentPath.push(node);

        if (node === n - 1) {
            result.push([...currentPath]);
        } else {
            for (const neighbor of graph[node]) {
                dfs(neighbor);
            }
        }

        currentPath.pop();
    }

    dfs(0);
    return result;
};