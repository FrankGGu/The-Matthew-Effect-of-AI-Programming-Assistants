var countCompleteComponents = function(n, edges) {
    const parent = new Array(n).fill().map((_, i) => i);
    const size = new Array(n).fill(1);
    const edgeCount = new Array(n).fill(0);

    function find(u) {
        if (parent[u] !== u) {
            parent[u] = find(parent[u]);
        }
        return parent[u];
    }

    function union(u, v) {
        const rootU = find(u);
        const rootV = find(v);
        if (rootU !== rootV) {
            if (size[rootU] > size[rootV]) {
                parent[rootV] = rootU;
                size[rootU] += size[rootV];
                edgeCount[rootU] += edgeCount[rootV] + 1;
            } else {
                parent[rootU] = rootV;
                size[rootV] += size[rootU];
                edgeCount[rootV] += edgeCount[rootU] + 1;
            }
        } else {
            edgeCount[rootU]++;
        }
    }

    for (const [u, v] of edges) {
        union(u, v);
    }

    const rootSet = new Set();
    for (let i = 0; i < n; i++) {
        rootSet.add(find(i));
    }

    let completeCount = 0;
    for (const root of rootSet) {
        const nodes = size[root];
        const edges = edgeCount[root];
        if (edges === nodes * (nodes - 1) / 2) {
            completeCount++;
        }
    }

    return completeCount;
};