var findRedundantDirectedConnection = function(edges) {
    let parent = Array(edges.length + 1).fill(0).map((_, i) => i);
    let rank = Array(edges.length + 1).fill(1);
    let nodeWithTwoParents = -1;

    const find = (x) => {
        if (parent[x] !== x) {
            parent[x] = find(parent[x]);
        }
        return parent[x];
    };

    const union = (x, y) => {
        let rootX = find(x);
        let rootY = find(y);
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

    for (let [u, v] of edges) {
        if (find(v) === v) {
            parent[v] = u;
        } else {
            nodeWithTwoParents = v;
            parent[v] = u;
        }
    }

    parent = Array(edges.length + 1).fill(0).map((_, i) => i);
    rank = Array(edges.length + 1).fill(1);
    let result = [];

    for (let [u, v] of edges) {
        if (u === nodeWithTwoParents && result.length === 0) {
            if (!union(u, v)) {
                result = [u, v];
            }
        } else {
            if (!union(u, v)) {
                result = [u, v];
            }
        }
    }

    return result.length ? result : [parent[nodeWithTwoParents], nodeWithTwoParents];
};