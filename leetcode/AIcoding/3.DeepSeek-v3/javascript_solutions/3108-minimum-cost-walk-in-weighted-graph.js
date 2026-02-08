function minimumCost(n, edges, query) {
    const parent = new Array(n).fill().map((_, i) => i);
    const weight = new Array(n).fill(-1);

    function find(u) {
        if (parent[u] !== u) {
            parent[u] = find(parent[u]);
        }
        return parent[u];
    }

    function union(u, v, w) {
        const rootU = find(u);
        const rootV = find(v);
        if (rootU !== rootV) {
            parent[rootV] = rootU;
            weight[rootU] &= weight[rootV] !== -1 ? weight[rootV] : w;
        } else {
            weight[rootU] &= w;
        }
    }

    for (const [u, v, w] of edges) {
        union(u, v, w);
    }

    const [s, t] = query;
    if (s === t) return 0;
    const rootS = find(s);
    const rootT = find(t);
    if (rootS !== rootT) return -1;
    return weight[rootS];
}