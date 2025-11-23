var minEdgeWeight = function(n, edges, queries) {
    const adj = Array(n).fill(null).map(() => []);
    for (const [u, v, w] of edges) {
        adj[u].push([v, w]);
        adj[v].push([u, w]);
    }

    const depth = Array(n).fill(0);
    const parent = Array(n).fill(null).map(() => Array(15).fill(-1));
    const weightSum = Array(n).fill(null).map(() => Array(65).fill(0));

    function dfs(u, p, d) {
        depth[u] = d;
        parent[u][0] = p;
        for (const [v, w] of adj[u]) {
            if (v !== p) {
                weightSum[v][w]++;
                for (let i = 1; i < 65; i++) {
                    weightSum[v][i] += weightSum[u][i];
                }
                dfs(v, u, d + 1);
            }
        }
    }

    dfs(0, -1, 0);

    for (let j = 1; j < 15; j++) {
        for (let i = 0; i < n; i++) {
            if (parent[i][j - 1] !== -1) {
                parent[i][j] = parent[parent[i][j - 1]][j - 1];
            }
        }
    }

    function lca(u, v) {
        if (depth[u] < depth[v]) {
            [u, v] = [v, u];
        }

        let diff = depth[u] - depth[v];
        for (let i = 14; i >= 0; i--) {
            if ((diff >> i) & 1) {
                u = parent[u][i];
            }
        }

        if (u === v) {
            return u;
        }

        for (let i = 14; i >= 0; i--) {
            if (parent[u][i] !== -1 && parent[u][i] !== parent[v][i]) {
                u = parent[u][i];
                v = parent[v][i];
            }
        }

        return parent[u][0];
    }

    const result = [];
    for (const [u, v] of queries) {
        const ancestor = lca(u, v);
        let totalWeight = depth[u] + depth[v] - 2 * depth[ancestor];
        let maxWeight = 0;
        for(let i = 1; i < 65; i++){
            let count = weightSum[u][i] + weightSum[v][i] - weightSum[ancestor][i];
            if(parent[ancestor][0] !== -1){
                count -= weightSum[parent[ancestor][0]][i];
            }
            maxWeight = Math.max(maxWeight, count);
        }
        result.push(totalWeight - maxWeight);
    }

    return result;
};