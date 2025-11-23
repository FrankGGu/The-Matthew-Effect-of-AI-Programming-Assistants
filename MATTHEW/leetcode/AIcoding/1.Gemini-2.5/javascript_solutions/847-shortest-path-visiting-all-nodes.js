var shortestPathLength = function(graph) {
    const n = graph.length;
    if (n === 1) {
        return 0;
    }

    const targetMask = (1 << n) - 1;
    const queue = [];
    const visited = Array(n).fill(0).map(() => Array(1 << n).fill(false));

    for (let i = 0; i < n; i++) {
        const initialMask = (1 << i);
        queue.push([i, initialMask, 0]);
        visited[i][initialMask] = true;
    }

    let head = 0;

    while (head < queue.length) {
        const [u, mask, dist] = queue[head++];

        if (mask === targetMask) {
            return dist;
        }

        for (const v of graph[u]) {
            const newMask = mask | (1 << v);

            if (!visited[v][newMask]) {
                visited[v][newMask] = true;
                queue.push([v, newMask, dist + 1]);
            }
        }
    }
};