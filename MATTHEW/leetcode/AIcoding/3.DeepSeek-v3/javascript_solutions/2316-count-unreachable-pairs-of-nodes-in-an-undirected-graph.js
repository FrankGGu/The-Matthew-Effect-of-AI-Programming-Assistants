var countPairs = function(n, edges) {
    const parent = new Array(n).fill(0).map((_, i) => i);
    const size = new Array(n).fill(1);

    const find = (u) => {
        if (parent[u] !== u) {
            parent[u] = find(parent[u]);
        }
        return parent[u];
    };

    const union = (u, v) => {
        const rootU = find(u);
        const rootV = find(v);
        if (rootU !== rootV) {
            if (size[rootU] > size[rootV]) {
                parent[rootV] = rootU;
                size[rootU] += size[rootV];
            } else {
                parent[rootU] = rootV;
                size[rootV] += size[rootU];
            }
        }
    };

    for (const [u, v] of edges) {
        union(u, v);
    }

    const rootSet = new Set();
    for (let i = 0; i < n; i++) {
        rootSet.add(find(i));
    }

    const components = [];
    for (const root of rootSet) {
        components.push(size[root]);
    }

    let totalPairs = n * (n - 1) / 2;
    for (const componentSize of components) {
        totalPairs -= componentSize * (componentSize - 1) / 2;
    }

    return totalPairs;
};