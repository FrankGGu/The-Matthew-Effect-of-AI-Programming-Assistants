var countSubtrees = function(n, edges, queries) {
    const adj = Array(n).fill(null).map(() => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    const ans = [];
    for (const query of queries) {
        const [u, v] = [query[0], query[1]];
        const subtreeSizes = Array(n).fill(0);

        const dfs = (node, parent) => {
            subtreeSizes[node] = 1;
            for (const neighbor of adj[node]) {
                if (neighbor !== parent) {
                    dfs(neighbor, node);
                    subtreeSizes[node] += subtreeSizes[neighbor];
                }
            }
        };

        const tempAdj = adj.map(neighbors => neighbors.slice());
        tempAdj[u] = tempAdj[u].filter(neighbor => neighbor !== v);
        tempAdj[v] = tempAdj[v].filter(neighbor => neighbor !== u);

        dfs(u, -1);
        const subtreeSizeU = subtreeSizes[u];

        subtreeSizes.fill(0);
        dfs(v, -1);
        const subtreeSizeV = subtreeSizes[v];

        ans.push(subtreeSizeV);

    }

    return ans;
};