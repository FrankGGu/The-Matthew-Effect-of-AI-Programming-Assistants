var shortestDistance = function(n, edges, queries) {
    const adj = Array(n).fill(null).map(() => Array(n).fill(Infinity));
    for (let i = 0; i < n; i++) {
        adj[i][i] = 0;
    }
    for (const [u, v, w] of edges) {
        adj[u][v] = w;
        adj[v][u] = w;
    }

    for (let k = 0; k < n; k++) {
        for (let i = 0; i < n; i++) {
            for (let j = 0; j < n; j++) {
                adj[i][j] = Math.min(adj[i][j], adj[i][k] + adj[k][j]);
            }
        }
    }

    const ans = [];
    for (const [u, v, w] of queries) {
        const tempAdj = adj.map(row => [...row]);
        for (let i = 0; i < n; i++) {
            for (let j = 0; j < n; j++) {
                tempAdj[i][j] = Math.min(tempAdj[i][j], Math.min(tempAdj[i][u] + w + tempAdj[v][j], tempAdj[i][v] + w + tempAdj[u][j]));
            }
        }
        let minDistance = Infinity;
        for (let i = 0; i < n; i++) {
            for (let j = i + 1; j < n; j++) {
                minDistance = Math.min(minDistance, tempAdj[i][j]);
            }
        }
        ans.push(minDistance === Infinity ? -1 : minDistance);
    }

    return ans;
};