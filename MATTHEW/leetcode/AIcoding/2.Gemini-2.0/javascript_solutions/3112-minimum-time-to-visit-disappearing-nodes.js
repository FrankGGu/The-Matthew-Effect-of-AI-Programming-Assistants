var minimumTime = function(n, edges, nodeTime) {
    const adj = Array(n).fill(null).map(() => []);
    for (const [u, v] of edges) {
        adj[u - 1].push(v - 1);
        adj[v - 1].push(u - 1);
    }

    const result = Array(n).fill(Infinity);
    result[0] = 0;
    const queue = [0];
    const visited = Array(n).fill(false);
    visited[0] = true;

    while (queue.length > 0) {
        const u = queue.shift();
        for (const v of adj[u]) {
            if (!visited[v]) {
                visited[v] = true;
                result[v] = Math.max(result[u] + 1, nodeTime[u]);
                queue.push(v);
            } else {
                result[v] = Math.min(result[v], Math.max(result[u] + 1, nodeTime[u]));
            }
        }
    }

    return result;
};