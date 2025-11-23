var countComponents = function(n, edges) {
    const parent = new Array(n).fill(0).map((_, i) => i);

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
            parent[rootV] = rootU;
        }
    }

    for (const [u, v] of edges) {
        union(u, v);
    }

    const roots = new Set();
    for (let i = 0; i < n; i++) {
        roots.add(find(i));
    }

    return roots.size;
};