class UnionFind {
    constructor(n) {
        this.parent = Array.from({ length: n }, (_, i) => i);
        this.numComponents = n;
    }

    find(i) {
        if (this.parent[i] === i) {
            return i;
        }
        this.parent[i] = this.find(this.parent[i]);
        return this.parent[i];
    }

    union(i, j) {
        const rootI = this.find(i);
        const rootJ = this.find(j);

        if (rootI !== rootJ) {
            this.parent[rootJ] = rootI;
            this.numComponents--;
            return true;
        }
        return false;
    }
}

var makeConnected = function(n, connections) {
    if (connections.length < n - 1) {
        return -1;
    }

    const uf = new UnionFind(n);

    for (const [u, v] of connections) {
        uf.union(u, v);
    }

    return uf.numComponents - 1;
};