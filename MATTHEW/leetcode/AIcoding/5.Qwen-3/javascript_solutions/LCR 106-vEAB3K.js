function isBipartite(graph) {
    const color = {};

    function dfs(node, c) {
        if (color[node] !== undefined) {
            return color[node] === c;
        }
        color[node] = c;
        for (const neighbor of graph[node]) {
            if (!dfs(neighbor, 1 - c)) {
                return false;
            }
        }
        return true;
    }

    for (let i = 0; i < graph.length; i++) {
        if (color[i] === undefined && !dfs(i, 0)) {
            return false;
        }
    }
    return true;
}