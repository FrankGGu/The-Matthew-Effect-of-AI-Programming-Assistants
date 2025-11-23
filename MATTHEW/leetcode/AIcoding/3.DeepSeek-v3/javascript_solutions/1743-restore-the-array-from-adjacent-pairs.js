var restoreArray = function(adjacentPairs) {
    const graph = new Map();
    for (const [u, v] of adjacentPairs) {
        if (!graph.has(u)) graph.set(u, []);
        if (!graph.has(v)) graph.set(v, []);
        graph.get(u).push(v);
        graph.get(v).push(u);
    }

    let root = null;
    for (const [key, neighbors] of graph) {
        if (neighbors.length === 1) {
            root = key;
            break;
        }
    }

    const result = [];
    const visited = new Set();
    const stack = [[root, null]];

    while (stack.length > 0) {
        const [node, parent] = stack.pop();
        result.push(node);
        visited.add(node);

        for (const neighbor of graph.get(node)) {
            if (neighbor !== parent && !visited.has(neighbor)) {
                stack.push([neighbor, node]);
            }
        }
    }

    return result;
};