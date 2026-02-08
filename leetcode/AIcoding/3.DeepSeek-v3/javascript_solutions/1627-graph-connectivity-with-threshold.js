class UnionFind {
    constructor(size) {
        this.parent = new Array(size + 1).fill(0).map((_, i) => i);
        this.rank = new Array(size + 1).fill(0);
    }

    find(u) {
        if (this.parent[u] !== u) {
            this.parent[u] = this.find(this.parent[u]);
        }
        return this.parent[u];
    }

    union(u, v) {
        const rootU = this.find(u);
        const rootV = this.find(v);
        if (rootU === rootV) return;
        if (this.rank[rootU] > this.rank[rootV]) {
            this.parent[rootV] = rootU;
        } else if (this.rank[rootU] < this.rank[rootV]) {
            this.parent[rootU] = rootV;
        } else {
            this.parent[rootV] = rootU;
            this.rank[rootU]++;
        }
    }
}

var areConnected = function(n, threshold, queries) {
    const uf = new UnionFind(n);
    for (let z = threshold + 1; z <= n; z++) {
        for (let multiple = z * 2; multiple <= n; multiple += z) {
            uf.union(z, multiple);
        }
    }

    const result = [];
    for (const [a, b] of queries) {
        result.push(uf.find(a) === uf.find(b));
    }
    return result;
};