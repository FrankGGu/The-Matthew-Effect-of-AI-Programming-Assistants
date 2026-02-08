class UnionFind {
    constructor(n) {
        this.parent = Array.from({ length: n }, (_, i) => i);
        this.rank = Array(n).fill(1);
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
    const uf = new UnionFind(n);
    const results = new Array(queries.length).fill(false);

    const indexedQueries = queries.map((q, i) => [q[2], q[0], q[1], i]);
    indexedQueries.sort((a, b) => a[0] - b[0]);
    edgeList.sort((a, b) => a[2] - b[2]);

    let j = 0;

    for (const [limit, u, v, index] of indexedQueries) {
        while (j < edgeList.length && edgeList[j][2] < limit) {
            uf.union(edgeList[j][0], edgeList[j][1]);
            j++;
        }
        results[index] = uf.find(u) === uf.find(v);
    }

    return results;
};