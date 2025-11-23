function countValidPaths(n, edges, start, end) {
    const graph = new Map();
    for (const [u, v] of edges) {
        if (!graph.has(u)) graph.set(u, []);
        if (!graph.has(v)) graph.set(v, []);
        graph.get(u).push(v);
        graph.get(v).push(u);
    }

    let count = 0;
    const visited = new Set();

    function dfs(node, target) {
        if (node === target) {
            count++;
            return;
        }
        visited.add(node);
        for (const neighbor of graph.get(node) || []) {
            if (!visited.has(neighbor)) {
                dfs(neighbor, target);
            }
        }
        visited.delete(node);
    }

    dfs(start, end);
    return count;
}