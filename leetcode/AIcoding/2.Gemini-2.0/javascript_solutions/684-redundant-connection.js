var findRedundantConnection = function(edges) {
    const n = edges.length;
    const parent = Array(n + 1).fill(0).map((_, i) => i);

    function find(x) {
        if (parent[x] !== x) {
            parent[x] = find(parent[x]);
        }
        return parent[x];
    }

    function union(x, y) {
        const rootX = find(x);
        const rootY = find(y);
        if (rootX !== rootY) {
            parent[rootX] = rootY;
            return true;
        }
        return false;
    }

    for (const edge of edges) {
        const u = edge[0];
        const v = edge[1];
        if (!union(u, v)) {
            return edge;
        }
    }
    return [];
};