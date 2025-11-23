class DSU {
    constructor(n) {
        this.parent = Array(n + 1).fill(0).map((_, i) => i);
        this.rank = Array(n + 1).fill(0);
    }

    find(i) {
        if (this.parent[i] === i) {
            return i;
        }
        this.parent[i] = this.find(this.parent[i]);
        return this.parent[i];
    }

    union(i, j) {
        let rootI = this.find(i);
        let rootJ = this.find(j);

        if (rootI !== rootJ) {
            if (this.rank[rootI] < this.rank[rootJ]) {
                this.parent[rootI] = rootJ;
            } else if (this.rank[rootI] > this.rank[rootJ]) {
                this.parent[rootJ] = rootI;
            } else {
                this.parent[rootJ] = rootI;
                this.rank[rootI]++;
            }
            return true;
        }
        return false;
    }
}

var pathQueries = function(n, edges, queries) {
    const dsu = new DSU(n);

    for (const [u, v] of edges) {
        dsu.union(u, v);
    }

    const results = [];
    for (const [u, v] of queries) {
        results.push(dsu.find(u) === dsu.find(v));
    }

    return results;
};