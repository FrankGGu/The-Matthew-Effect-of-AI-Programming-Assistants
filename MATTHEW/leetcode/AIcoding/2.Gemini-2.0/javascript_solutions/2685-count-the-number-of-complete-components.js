var countCompleteComponents = function(n, edges) {
    const adj = Array(n).fill(null).map(() => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    const visited = new Array(n).fill(false);
    let count = 0;

    function bfs(node) {
        const q = [node];
        visited[node] = true;
        let nodes = 0;
        let edgesCount = 0;

        while (q.length > 0) {
            const u = q.shift();
            nodes++;
            edgesCount += adj[u].length;

            for (const v of adj[u]) {
                if (!visited[v]) {
                    visited[v] = true;
                    q.push(v);
                }
            }
        }

        edgesCount /= 2;
        return edgesCount === nodes * (nodes - 1) / 2;
    }

    for (let i = 0; i < n; i++) {
        if (!visited[i]) {
            if (bfs(i)) {
                count++;
            }
        }
    }

    return count;
};