var findRedundantConnection = function(edges) {
    const parent = Array(edges.length + 1).fill(0).map((_, i) => i);

    function find(u) {
        if (parent[u] !== u) {
            parent[u] = find(parent[u]);
        }
        return parent[u];
    }

    for (const [u, v] of edges) {
        const rootU = find(u);
        const rootV = find(v);
        if (rootU === rootV) {
            return [u, v];
        }
        parent[rootV] = rootU;
    }

    return [];
};