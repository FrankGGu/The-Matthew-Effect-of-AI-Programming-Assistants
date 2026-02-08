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

var regionsBySlashes = function(grid) {
    const n = grid.length;
    const uf = new UnionFind(n * n * 4);

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            const index = i * n + j;
            if (grid[i][j] === ' ') {
                uf.union(index * 4, index * 4 + 1);
                uf.union(index * 4 + 1, index * 4 + 2);
                uf.union(index * 4 + 2, index * 4 + 3);
            } else if (grid[i][j] === '/') {
                uf.union(index * 4, index * 4 + 2);
            } else if (grid[i][j] === '\\') {
                uf.union(index * 4 + 1, index * 4 + 3);
            }
            if (i < n - 1) {
                uf.union(index * 4 + 2, ((i + 1) * n + j) * 4);
            }
            if (j < n - 1) {
                uf.union(index * 4 + 1, (index + 1) * 4);
            }
        }
    }

    const regions = new Set();
    for (let i = 0; i < n * n * 4; i++) {
        regions.add(uf.find(i));
    }

    return regions.size;
};