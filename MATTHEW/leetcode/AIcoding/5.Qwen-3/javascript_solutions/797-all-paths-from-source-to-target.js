function allPathsSourceTarget(graph) {
    const result = [];
    const path = [0];

    function dfs(node) {
        if (node === graph.length - 1) {
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
}