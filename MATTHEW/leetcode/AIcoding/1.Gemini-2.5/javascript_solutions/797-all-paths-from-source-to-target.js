var allPathsSourceTarget = function(graph) {
    const n = graph.length;
    const result = [];
    const path = [];

    function dfs(node) {
        path.push(node);

        if (node === n - 1) {
            result.push([...path]);
        } else {
            for (const neighbor of graph[node]) {
                dfs(neighbor);
            }
        }

        path.pop();
    }

    dfs(0);
    return result;
};