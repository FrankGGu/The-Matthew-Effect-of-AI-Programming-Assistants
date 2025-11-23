var countWaysII = function(n, edges) {
    const MOD = 1e9 + 7;
    const parent = new Array(n).fill(-1);
    const rank = new Array(n).fill(0);

    function find(u) {
        if (parent[u] === -1) return u;
        parent[u] = find(parent[u]);
        return parent[u];
    }

    function union(u, v) {
        const rootU = find(u);
        const rootV = find(v);
        if (rootU === rootV) return false;
        if (rank[rootU] > rank[rootV]) {
            parent[rootV] = rootU;
        } else if (rank[rootU] < rank[rootV]) {
            parent[rootU] = rootV;
        } else {
            parent[rootV] = rootU;
            rank[rootU]++;
        }
        return true;
    }

    edges.sort((a, b) => a[2] - b[2]);

    let res = 1;
    let i = 0;
    while (i < edges.length) {
        let j = i;
        while (j < edges.length && edges[j][2] === edges[i][2]) {
            j++;
        }

        const uniqueWeights = new Set();
        for (let k = i; k < j; k++) {
            const [u, v, w] = edges[k];
            uniqueWeights.add(find(u));
            uniqueWeights.add(find(v));
        }

        const nodes = Array.from(uniqueWeights);
        const nodeToIndex = new Map();
        nodes.forEach((node, idx) => nodeToIndex.set(node, idx));

        const m = nodes.length;
        const adj = new Array(m).fill(0).map(() => new Array(m).fill(0));
        const degree = new Array(m).fill(0);

        for (let k = i; k < j; k++) {
            const [u, v, w] = edges[k];
            const rootU = find(u);
            const rootV = find(v);
            const idxU = nodeToIndex.get(rootU);
            const idxV = nodeToIndex.get(rootV);
            adj[idxU][idxV]++;
            adj[idxV][idxU]++;
            degree[idxU]++;
            degree[idxV]++;
        }

        let cnt = 0;
        const visited = new Array(m).fill(false);

        function dfs(u) {
            visited[u] = true;
            for (let v = 0; v < m; v++) {
                if (adj[u][v] > 0 && !visited[v]) {
                    dfs(v);
                }
            }
        }

        for (let u = 0; u < m; u++) {
            if (!visited[u]) {
                dfs(u);
                cnt++;
            }
        }

        res = (res * cnt) % MOD;

        for (let k = i; k < j; k++) {
            const [u, v, w] = edges[k];
            union(u, v);
        }

        i = j;
    }

    return res;
};