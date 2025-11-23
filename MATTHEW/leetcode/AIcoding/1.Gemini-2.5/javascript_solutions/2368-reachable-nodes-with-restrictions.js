var reachableNodes = function(n, edges, restricted) {
    const adj = new Array(n).fill(0).map(() => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    const restrictedSet = new Set(restricted);
    const visited = new Array(n).fill(false);
    let reachableCount = 0;

    if (restrictedSet.has(0)) {
        return 0;
    }

    const queue = [0];
    visited[0] = true;

    while (queue.length > 0) {
        const node = queue.shift();
        reachableCount++;

        for (const neighbor of adj[node]) {
            if (!visited[neighbor] && !restrictedSet.has(neighbor)) {
                visited[neighbor] = true;
                queue.push(neighbor);
            }
        }
    }

    return reachableCount;
};