var findRedundantDirectedConnection = function(edges) {
    const n = edges.length;
    const parent = new Array(n + 1).fill(0).map((_, i) => i);
    let candidate1 = null, candidate2 = null;
    const parentMap = new Array(n + 1).fill(0);

    for (const [u, v] of edges) {
        if (parentMap[v] !== 0) {
            candidate1 = [parentMap[v], v];
            candidate2 = [u, v];
            break;
        }
        parentMap[v] = u;
    }

    function find(u) {
        while (parent[u] !== u) {
            parent[u] = parent[parent[u]];
            u = parent[u];
        }
        return u;
    }

    for (const [u, v] of edges) {
        if (candidate2 && u === candidate2[0] && v === candidate2[1]) continue;
        const rootU = find(u);
        const rootV = find(v);
        if (rootU === rootV) {
            if (candidate1) return candidate1;
            return [u, v];
        }
        parent[rootV] = rootU;
    }

    return candidate2;
};