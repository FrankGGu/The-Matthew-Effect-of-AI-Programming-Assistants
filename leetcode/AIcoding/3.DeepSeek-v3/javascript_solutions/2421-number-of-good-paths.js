var numberOfGoodPaths = function(vals, edges) {
    const n = vals.length;
    const parent = new Array(n).fill(0).map((_, i) => i);
    const count = new Array(n).fill(1);
    const adj = new Array(n).fill(0).map(() => []);

    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    const nodes = vals.map((val, idx) => [val, idx]);
    nodes.sort((a, b) => a[0] - b[0]);

    function find(u) {
        if (parent[u] !== u) {
            parent[u] = find(parent[u]);
        }
        return parent[u];
    }

    let res = n;

    for (let i = 0; i < n; ) {
        let j = i;
        while (j < n && nodes[j][0] === nodes[i][0]) {
            j++;
        }

        for (let k = i; k < j; k++) {
            const u = nodes[k][1];
            for (const v of adj[u]) {
                if (vals[u] >= vals[v]) {
                    const rootU = find(u);
                    const rootV = find(v);
                    if (rootU !== rootV) {
                        parent[rootV] = rootU;
                        count[rootU] += count[rootV];
                    }
                }
            }
        }

        const rootCount = new Map();
        for (let k = i; k < j; k++) {
            const root = find(nodes[k][1]);
            rootCount.set(root, (rootCount.get(root) || 0) + 1);
        }

        for (const cnt of rootCount.values()) {
            res += cnt * (cnt - 1) / 2;
        }

        i = j;
    }

    return res;
};