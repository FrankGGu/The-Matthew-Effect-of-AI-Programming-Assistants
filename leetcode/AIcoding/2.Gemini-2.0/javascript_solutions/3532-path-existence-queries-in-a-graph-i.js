var solve = function(n, edges, queries) {
    const adj = Array(n).fill(null).map(() => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    const bfs = (start, end) => {
        const visited = Array(n).fill(false);
        const queue = [start];
        visited[start] = true;

        while (queue.length > 0) {
            const u = queue.shift();
            if (u === end) {
                return true;
            }

            for (const v of adj[u]) {
                if (!visited[v]) {
                    visited[v] = true;
                    queue.push(v);
                }
            }
        }

        return false;
    };

    const result = [];
    for (const [start, end] of queries) {
        result.push(bfs(start, end));
    }

    return result;
};