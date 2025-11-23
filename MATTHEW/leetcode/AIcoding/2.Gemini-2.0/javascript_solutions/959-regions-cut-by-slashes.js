var regionsBySlashes = function(grid) {
    const n = grid.length;
    const uf = new UnionFind(4 * n * n);

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            const idx = i * n + j;
            if (grid[i][j] === '/') {
                uf.union(4 * idx + 0, 4 * idx + 1);
                uf.union(4 * idx + 2, 4 * idx + 3);
            } else if (grid[i][j] === '\\') {
                uf.union(4 * idx + 0, 4 * idx + 3);
                uf.union(4 * idx + 1, 4 * idx + 2);
            } else {
                uf.union(4 * idx + 0, 4 * idx + 1);
                uf.union(4 * idx + 1, 4 * idx + 2);
                uf.union(4 * idx + 2, 4 * idx + 3);
            }

            if (i > 0) {
                uf.union(4 * idx + 0, 4 * (idx - n) + 2);
            }
            if (i < n - 1) {
                uf.union(4 * idx + 2, 4 * (idx + n) + 0);
            }
            if (j > 0) {
                uf.union(4 * idx + 3, 4 * (idx - 1) + 1);
            }
            if (j < n - 1) {
                uf.union(4 * idx + 1, 4 * (idx + 1) + 3);
            }
        }
    }

    let count = 0;
    for (let i = 0; i < 4 * n * n; i++) {
        if (uf.find(i) === i) {
            count++;
        }
    }

    return count;
};

class UnionFind {
    constructor(n) {
        this.parent = Array(n).fill(0).map((_, i) => i);
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
            this.parent[rootX] = rootY;
        }
    }
}