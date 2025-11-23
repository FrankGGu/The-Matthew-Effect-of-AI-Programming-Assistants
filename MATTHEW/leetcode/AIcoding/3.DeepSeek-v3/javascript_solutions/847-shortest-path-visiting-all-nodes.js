var shortestPathLength = function(graph) {
    const n = graph.length;
    const targetMask = (1 << n) - 1;
    const queue = [];
    const visited = new Set();

    for (let i = 0; i < n; i++) {
        const mask = 1 << i;
        queue.push([i, mask]);
        visited.add(`${i},${mask}`);
    }

    let steps = 0;

    while (queue.length > 0) {
        const size = queue.length;
        for (let i = 0; i < size; i++) {
            const [node, mask] = queue.shift();
            if (mask === targetMask) {
                return steps;
            }
            for (const neighbor of graph[node]) {
                const newMask = mask | (1 << neighbor);
                const key = `${neighbor},${newMask}`;
                if (!visited.has(key)) {
                    visited.add(key);
                    queue.push([neighbor, newMask]);
                }
            }
        }
        steps++;
    }

    return -1;
};