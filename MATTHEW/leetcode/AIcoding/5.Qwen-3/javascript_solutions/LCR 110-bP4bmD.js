function allPathsSourceTarget(graph) {
    const result = [];
    const path = [];

    function dfs(node) {
        path.push(node);
        if (node === graph.length - 1) {
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
}