var findRedundantDirectedConnection = function(edges) {
    const parent = new Array(edges.length + 1).fill(0);
    const rank = new Array(edges.length + 1).fill(0);

    const find = (x) => {
        if (parent[x] !== 0) {
            return find(parent[x]);
        }
        return x;
    };

    const union = (x, y) => {
        const rootX = find(x);
        const rootY = find(y);
        if (rootX === rootY) return false;
        if (rank[rootX] > rank[rootY]) {
            parent[rootY] = rootX;
        } else if (rank[rootX] < rank[rootY]) {
            parent[rootX] = rootY;
        } else {
            parent[rootY] = rootX;
            rank[rootX]++;
        }
        return true;
    };

    let edgeWithTwoParents = null;

    for (const [u, v] of edges) {
        if (parent[v] === 0) {
            parent[v] = u;
            if (!union(u, v)) {
                return [u, v];
            }
        } else {
            edgeWithTwoParents = [parent[v], v];
            parent[v] = u;
            if (!union(u, v)) {
                return edgeWithTwoParents || [u, v];
            }
        }
    }

    return edgeWithTwoParents;
};