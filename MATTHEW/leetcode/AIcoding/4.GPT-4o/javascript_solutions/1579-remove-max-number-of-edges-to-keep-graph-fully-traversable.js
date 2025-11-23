var maxNumEdgesToRemove = function(n, edges) {
    let parent = Array(n + 1).fill(0).map((_, i) => i);
    let rank = Array(n + 1).fill(0);

    const find = (x) => {
        if (parent[x] !== x) {
            parent[x] = find(parent[x]);
        }
        return parent[x];
    };

    const union = (x, y) => {
        let rootX = find(x);
        let rootY = find(y);
        if (rootX !== rootY) {
            if (rank[rootX] > rank[rootY]) {
                parent[rootY] = rootX;
            } else if (rank[rootX] < rank[rootY]) {
                parent[rootX] = rootY;
            } else {
                parent[rootY] = rootX;
                rank[rootX]++;
            }
            return true;
        }
        return false;
    };

    let totalEdges = 0;
    let usedEdges = 0;

    for (let [type, u, v] of edges) {
        if (type === 1) {
            if (union(u, v)) {
                usedEdges++;
            }
            totalEdges++;
        }
    }

    for (let [type, u, v] of edges) {
        if (type === 2) {
            if (union(u, v)) {
                usedEdges++;
            }
            totalEdges++;
        }
    }

    for (let i = 1; i <= n; i++) {
        if (find(i) !== find(1)) {
            return -1;
        }
    }

    for (let [type, u, v] of edges) {
        if (type === 3) {
            if (union(u, v)) {
                usedEdges++;
            }
            totalEdges++;
        }
    }

    return edges.length - usedEdges;
};