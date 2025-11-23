var restoreArray = function(adjacentPairs) {
    const graph = new Map();
    const degrees = new Map();

    for (const [u, v] of adjacentPairs) {
        if (!graph.has(u)) graph.set(u, []);
        if (!graph.has(v)) graph.set(v, []);
        graph.get(u).push(v);
        graph.get(v).push(u);

        degrees.set(u, (degrees.get(u) || 0) + 1);
        degrees.set(v, (degrees.get(v) || 0) + 1);
    }

    let start = null;
    for (const [node, degree] of degrees) {
        if (degree === 1) {
            start = node;
            break;
        }
    }

    const result = [];
    const visited = new Set();
    let current = start;

    while (result.length < adjacentPairs.length + 1) {
        result.push(current);
        visited.add(current);

        const neighbors = graph.get(current);
        if (neighbors) {
            for (const neighbor of neighbors) {
                if (!visited.has(neighbor)) {
                    current = neighbor;
                    break;
                }
            }
        } else {
            break;
        }
    }

    return result;
};