class UnionFind {
    constructor(size) {
        this.parent = new Array(size).fill(0).map((_, index) => index);
        this.rank = new Array(size).fill(1);
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

var distanceLimitedPathsExist = function(n, edgeList, queries) {
    const results = new Array(queries.length);
    const indexedQueries = queries.map((query, index) => [...query, index]).sort((a, b) => a[2] - b[2]);
    edgeList.sort((a, b) => a[2] - b[2]);

    const uf = new UnionFind(n);
    let edgeIndex = 0;

    for (const [u, v, limit, queryIndex] of indexedQueries) {
        while (edgeIndex < edgeList.length && edgeList[edgeIndex][2] < limit) {
            uf.union(edgeList[edgeIndex][0], edgeList[edgeIndex][1]);
            edgeIndex++;
        }
        results[queryIndex] = uf.find(u) === uf.find(v);
    }

    return results;
};