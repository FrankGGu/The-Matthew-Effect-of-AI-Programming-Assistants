var minEdgeReversals = function(n, edges) {
    const adj = Array(n).fill(null).map(() => []);
    for (const [u, v] of edges) {
        adj[u].push([v, 0]);
        adj[v].push([u, 1]);
    }

    const countReversed = (start) => {
        const q = [[start, 0]];
        const visited = new Array(n).fill(false);
        visited[start] = true;
        let reversedEdges = 0;

        while (q.length > 0) {
            const [node, revCount] = q.shift();
            reversedEdges += revCount;

            for (const [neighbor, weight] of adj[node]) {
                if (!visited[neighbor]) {
                    visited[neighbor] = true;
                    q.push([neighbor, weight]);
                }
            }
        }

        return reversedEdges;
    };

    const results = [];
    for (let i = 0; i < n; i++) {
        results.push(countReversed(i));
    }

    return results;
};