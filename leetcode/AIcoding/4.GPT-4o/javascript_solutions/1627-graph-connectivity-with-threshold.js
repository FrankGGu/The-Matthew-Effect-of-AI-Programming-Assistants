class UnionFind {
    constructor(n) {
        this.parent = new Array(n + 1).fill(0).map((_, index) => index);
        this.rank = new Array(n + 1).fill(1);
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

var areConnected = function(n, threshold, queries) {
    const uf = new UnionFind(n);

    for (let i = threshold + 1; i <= n; i++) {
        for (let j = i + i; j <= n; j += i) {
            uf.union(i, j);
        }
    }

    const results = [];
    for (const [x, y] of queries) {
        results.push(uf.find(x) === uf.find(y));
    }

    return results;
};