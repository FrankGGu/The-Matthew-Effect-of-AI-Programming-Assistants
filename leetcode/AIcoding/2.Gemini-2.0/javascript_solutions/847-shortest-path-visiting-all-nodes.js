var shortestPathLength = function(graph) {
    const n = graph.length;
    if (n === 1) return 0;

    const queue = [];
    const visited = new Array(n).fill(null).map(() => new Array(1 << n).fill(false));
    let target = (1 << n) - 1;

    for (let i = 0; i < n; i++) {
        queue.push([i, 1 << i, 0]);
        visited[i][1 << i] = true;
    }

    while (queue.length > 0) {
        const [node, mask, dist] = queue.shift();

        if (mask === target) {
            return dist;
        }

        for (const neighbor of graph[node]) {
            const newMask = mask | (1 << neighbor);
            if (!visited[neighbor][newMask]) {
                visited[neighbor][newMask] = true;
                queue.push([neighbor, newMask, dist + 1]);
            }
        }
    }

    return -1;
};