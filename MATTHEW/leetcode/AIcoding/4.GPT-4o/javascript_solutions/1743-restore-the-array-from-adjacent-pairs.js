function restoreArray(adjacentPairs) {
    const graph = new Map();
    for (const [a, b] of adjacentPairs) {
        if (!graph.has(a)) graph.set(a, []);
        if (!graph.has(b)) graph.set(b, []);
        graph.get(a).push(b);
        graph.get(b).push(a);
    }

    const result = [];
    const visited = new Set();

    function dfs(node) {
        visited.add(node);
        result.push(node);
        for (const neighbor of graph.get(node)) {
            if (!visited.has(neighbor)) {
                dfs(neighbor);
            }
        }
    }

    dfs(adjacentPairs[0][0]);
    return result;
}