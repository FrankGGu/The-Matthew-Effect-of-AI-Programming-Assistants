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

var distanceLimitedPathsExist = function(n, edgeList, queries) {
    edgeList.sort((a, b) => a[2] - b[2]);
    const queriesWithIndex = queries.map((query, index) => [...query, index]);
    queriesWithIndex.sort((a, b) => a[2] - b[2]);

    const uf = new UnionFind(n);
    const result = Array(queries.length).fill(false);
    let edgeIndex = 0;

    for (const [u, v, limit, originalIndex] of queriesWithIndex) {
        while (edgeIndex < edgeList.length && edgeList[edgeIndex][2] < limit) {
            const [x, y, _] = edgeList[edgeIndex];
            uf.union(x, y);
            edgeIndex++;
        }
        result[originalIndex] = uf.find(u) === uf.find(v);
    }

    return result;
};