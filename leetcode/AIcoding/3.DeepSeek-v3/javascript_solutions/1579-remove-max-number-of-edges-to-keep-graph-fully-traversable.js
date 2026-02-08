class UnionFind {
    constructor(size) {
        this.parent = new Array(size + 1).fill(0).map((_, i) => i);
        this.rank = new Array(size + 1).fill(0);
        this.count = size;
    }

    find(x) {
        if (this.parent[x] !== x) {
            this.parent[x] = this.find(this.parent[x]);
        }
        return this.parent[x];
    }

    union(x, y) {
        let rootX = this.find(x);
        let rootY = this.find(y);
        if (rootX === rootY) return false;
        if (this.rank[rootX] > this.rank[rootY]) {
            this.parent[rootY] = rootX;
        } else if (this.rank[rootX] < this.rank[rootY]) {
            this.parent[rootX] = rootY;
        } else {
            this.parent[rootY] = rootX;
            this.rank[rootX]++;
        }
        this.count--;
        return true;
    }
}

var maxNumEdgesToRemove = function(n, edges) {
    edges.sort((a, b) => b[0] - a[0]);
    let uf1 = new UnionFind(n);
    let uf2 = new UnionFind(n);
    let removed = 0;

    for (let [type, u, v] of edges) {
        if (type === 3) {
            let res1 = uf1.union(u, v);
            let res2 = uf2.union(u, v);
            if (!res1 && !res2) {
                removed++;
            }
        } else if (type === 1) {
            if (!uf1.union(u, v)) {
                removed++;
            }
        } else if (type === 2) {
            if (!uf2.union(u, v)) {
                removed++;
            }
        }
    }

    if (uf1.count !== 1 || uf2.count !== 1) {
        return -1;
    }

    return removed;
};