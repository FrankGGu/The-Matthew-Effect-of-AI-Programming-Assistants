var shortestPathLength = function(graph) {
    const n = graph.length;
    const queue = [];
    const visited = new Set();
    const allVisited = (1 << n) - 1;

    for (let i = 0; i < n; i++) {
        queue.push([i, 1 << i]);
        visited.add(`${i},${1 << i}`);
    }

    let steps = 0;

    while (queue.length > 0) {
        const size = queue.length;
        for (let i = 0; i < size; i++) {
            const [node, mask] = queue.shift();
            if (mask === allVisited) return steps;
            for (const neighbor of graph[node]) {
                const newMask = mask | (1 << neighbor);
                if (!visited.has(`${neighbor},${newMask}`)) {
                    visited.add(`${neighbor},${newMask}`);
                    queue.push([neighbor, newMask]);
                }
            }
        }
        steps++;
    }

    return -1;
};