var distanceLimitedPathsExist = function(n, edgeList, queries) {
    edgeList.sort((a, b) => a[2] - b[2]);
    const m = queries.length;
    const results = new Array(m);
    const queryIndices = Array.from(Array(m).keys()).sort((a, b) => queries[a][2] - queries[b][2]);
    const uf = new UnionFind(n);
    let edgeIndex = 0;

    for (let i = 0; i < m; i++) {
        const queryIndex = queryIndices[i];
        const p = queries[queryIndex][0];
        const q = queries[queryIndex][1];
        const limit = queries[queryIndex][2];

        while (edgeIndex < edgeList.length && edgeList[edgeIndex][2] < limit) {
            const u = edgeList[edgeIndex][0];
            const v = edgeList[edgeIndex][1];
            uf.union(u, v);
            edgeIndex++;
        }

        results[queryIndex] = uf.find(p) === uf.find(q);
    }

    return results;
};

class UnionFind {
    constructor(n) {
        this.parent = new Array(n);
        this.rank = new Array(n).fill(0);
        for (let i = 0; i < n; i++) {
            this.parent[i] = i;
        }
    }

    find(x) {
        if (this.parent[x] !== x) {
            this.parent[x] = this.find(this.parent[x]);
        }
        return this.parent[x];
    }

    union(x, y) {
        const rootX = this.find(x);
        const rootY = this.find(y);

        if (rootX !== rootY) {
            if (this.rank[rootX] > this.rank[rootY]) {
                this.parent[rootY] = rootX;
            } else if (this.rank[rootX] < this.rank[rootY]) {
                this.parent[rootX] = rootY;
            } else {
                this.parent[rootY] = rootX;
                this.rank[rootX]++;
            }
        }
    }
}