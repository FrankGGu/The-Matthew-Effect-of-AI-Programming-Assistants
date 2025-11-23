var minScore = function(n, roads) {
    const adj = new Array(n + 1).fill(0).map(() => []);
    for (const [u, v, dist] of roads) {
        adj[u].push([v, dist]);
        adj[v].push([u, dist]);
    }

    const visited = new Set();
    const queue = [1];
    visited.add(1);

    let minScore = Infinity;

    let head = 0;
    while (head < queue.length) {
        const u = queue[head++];

        for (const [v, dist] of adj[u]) {
            minScore = Math.min(minScore, dist);

            if (!visited.has(v)) {
                visited.add(v);
                queue.push(v);
            }
        }
    }

    return minScore;
};