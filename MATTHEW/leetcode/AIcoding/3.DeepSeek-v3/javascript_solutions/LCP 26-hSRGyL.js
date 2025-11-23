var findShortestPath = function(edges, start, end) {
    const graph = {};
    for (const [u, v] of edges) {
        if (!graph[u]) graph[u] = [];
        if (!graph[v]) graph[v] = [];
        graph[u].push(v);
        graph[v].push(u);
    }

    const visited = new Set();
    const queue = [[start, [start]]];

    while (queue.length > 0) {
        const [node, path] = queue.shift();
        if (node === end) {
            return path;
        }
        if (visited.has(node)) continue;
        visited.add(node);

        for (const neighbor of graph[node] || []) {
            if (!visited.has(neighbor)) {
                queue.push([neighbor, [...path, neighbor]]);
            }
        }
    }

    return [];
};