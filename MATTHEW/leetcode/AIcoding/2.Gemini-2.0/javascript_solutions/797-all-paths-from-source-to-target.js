var allPathsSourceTarget = function(graph) {
    const n = graph.length;
    const result = [];
    const path = [0];

    function dfs(node) {
        if (node === n - 1) {
            result.push([...path]);
            return;
        }

        for (const neighbor of graph[node]) {
            path.push(neighbor);
            dfs(neighbor);
            path.pop();
        }
    }

    dfs(0);
    return result;
};