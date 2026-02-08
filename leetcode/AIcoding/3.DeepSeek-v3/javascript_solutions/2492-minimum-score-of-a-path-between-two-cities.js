var minScore = function(n, roads) {
    const adj = new Array(n + 1).fill().map(() => []);
    for (const [a, b, dist] of roads) {
        adj[a].push([b, dist]);
        adj[b].push([a, dist]);
    }

    const visited = new Array(n + 1).fill(false);
    let minDist = Infinity;
    const queue = [1];
    visited[1] = true;

    while (queue.length > 0) {
        const node = queue.shift();
        for (const [neighbor, dist] of adj[node]) {
            minDist = Math.min(minDist, dist);
            if (!visited[neighbor]) {
                visited[neighbor] = true;
                queue.push(neighbor);
            }
        }
    }

    return minDist;
};