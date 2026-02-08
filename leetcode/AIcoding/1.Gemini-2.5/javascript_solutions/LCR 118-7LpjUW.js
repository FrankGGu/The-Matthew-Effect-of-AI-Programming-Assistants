var findRedundantConnection = function(edges) {
    let maxNode = 0;
    for (const edge of edges) {
        maxNode = Math.max(maxNode, edge[0], edge[1]);
    }

    const parent = new Array(maxNode + 1).fill(0).map((_, i) => i);

    function find(i) {
        if (parent[i] === i) {
            return i;
        }
        parent[i] = find(parent[i]);
        return parent[i];
    }

    function union(i, j) {
        const rootI = find(i);
        const rootJ = find(j);
        if (rootI !== rootJ) {
            parent[rootI] = rootJ;
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
};