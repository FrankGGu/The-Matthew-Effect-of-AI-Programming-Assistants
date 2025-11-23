var minEdgeWeightEquilibriumQueries = function(n, edges, queries) {
    let n_nodes = n;
    let adj = Array(n).fill(0).map(() => []);
    let depth = Array(n).fill(0);
    let pathCounts = Array(n).fill(0).map(() => Array(27).fill(0));

    let MAX_LOG = (n === 1) ? 1 : Math.floor(Math.log2(n)) + 1;

    let parent = Array(MAX_LOG).fill(0).map(() => Array(n).fill(-1));

    function dfs(u, p, d, edgeWeightToU) {
        depth[u] = d;
        parent[0][u] = p;

        if (p !== -1) {
            for (let w = 1; w <= 26; w++) {
                pathCounts[u][w] = pathCounts[p][w];
            }
            pathCounts[u][edgeWeightToU]++;
        } else {
            for (let w = 1; w <= 26; w++) {
                pathCounts[u][w] = 0;
            }
        }

        for (const [v, w] of adj[u]) {
            if (v === p) continue;
            dfs(v, u, d + 1, w);
        }
    }

    function precomputeLCA() {
        for (let k = 1; k < MAX_LOG; k++) {
            for (let i = 0; i < n_nodes; i++) {
                if (parent[k - 1][i] !== -1) {
                    parent[k][i] = parent[k - 1][parent[k - 1][i]];
                } else {
                    parent[k][i] = -1;
                }
            }
        }
    }

    function getLCA(u, v) {
        if (depth[u] < depth[v]) {
            [u, v] = [v, u];
        }

        for (let k = MAX_LOG - 1; k >= 0; k--) {
            if (parent[k][u] !== -1 && depth[parent[k][u]] >= depth[v]) {
                u = parent[k][u];
            }
        }

        if (u === v) return u;

        for (let k = MAX_LOG - 1; k >= 0; k--) {
            if (parent[k][u] !== -1 && parent[k][v] !== -1 && parent[k][u] !== parent[k][v]) {
                u = parent[k][u];
                v = parent[k][v];
            }
        }

        return parent[0][u];
    }

    for (const [u, v, w] of edges) {
        adj[u].push([v, w]);
        adj[v].push([u, w]);
    }

    dfs(0, -1, 0, 0); 

    precomputeLCA();

    const results = [];
    for (const [u, v] of queries) {
        const lca = getLCA(u, v);
        const totalEdgesOnPath = depth[u] + depth[v] - 2 * depth[lca];

        let minChanges = Infinity;

        for (let targetWeight = 1; targetWeight <= 26; targetWeight++) {
            const countOfTargetWeight = pathCounts[u][targetWeight] + pathCounts[v][targetWeight] - 2 * pathCounts[lca][targetWeight];
            const changesNeeded = totalEdgesOnPath - countOfTargetWeight;
            minChanges = Math.min(minChanges, changesNeeded);
        }
        results.push(minChanges);
    }

    return results;
};