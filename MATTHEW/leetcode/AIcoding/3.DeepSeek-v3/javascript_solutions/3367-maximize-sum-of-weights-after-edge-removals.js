class UnionFind {
    constructor(size) {
        this.parent = Array(size).fill().map((_, i) => i);
        this.rank = Array(size).fill(0);
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
        if (rootU === rootV) return false;
        if (this.rank[rootU] > this.rank[rootV]) {
            this.parent[rootV] = rootU;
        } else if (this.rank[rootU] < this.rank[rootV]) {
            this.parent[rootU] = rootV;
        } else {
            this.parent[rootV] = rootU;
            this.rank[rootU]++;
        }
        return true;
    }
}

function maxSumAfterEdgeRemoval(n, edges) {
    edges.sort((a, b) => b[2] - a[2]);
    const uf = new UnionFind(n);
    let total = 0;
    const componentSizes = Array(n).fill(1);
    const componentSums = Array(n).fill(0);
    for (const [u, v, w] of edges) {
        const rootU = uf.find(u);
        const rootV = uf.find(v);
        if (rootU !== rootV) {
            total += componentSizes[rootU] * componentSizes[rootV] * w;
            componentSums[rootU] += componentSums[rootV] + w;
            componentSizes[rootU] += componentSizes[rootV];
            uf.parent[rootV] = rootU;
        } else {
            componentSums[rootU] += w;
        }
    }
    return total;
}