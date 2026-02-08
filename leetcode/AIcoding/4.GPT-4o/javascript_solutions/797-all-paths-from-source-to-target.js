var allPathsSourceTarget = function(graph) {
    const result = [];
    const dfs = (node, path) => {
        path.push(node);
        if (node === graph.length - 1) {
            result.push([...path]);
        } else {
            for (const neighbor of graph[node]) {
                dfs(neighbor, path);
            }
        }
        path.pop();
    };
    dfs(0, []);
    return result;
};