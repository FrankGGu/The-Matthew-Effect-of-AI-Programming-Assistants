var findRedundantConnection = function(edges) {
    const n = edges.length;
    const parent = Array(n + 1).fill(0).map((_, i) => i);

    const find = (i) => {
        if (parent[i] === i) {
            return i;
        }
        return parent[i] = find(parent[i]);
    };

    const union = (i, j) => {
        const rootI = find(i);
        const rootJ = find(j);
        if (rootI !== rootJ) {
            parent[rootI] = rootJ;
            return true;
        }
        return false;
    };

    for (const [u, v] of edges) {
        if (!union(u, v)) {
            return [u, v];
        }
    }

    return [];
};