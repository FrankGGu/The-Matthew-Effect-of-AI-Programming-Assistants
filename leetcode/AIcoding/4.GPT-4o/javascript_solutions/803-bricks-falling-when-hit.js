class UnionFind {
    constructor(n) {
        this.parent = new Array(n).fill(0).map((_, index) => index);
        this.rank = new Array(n).fill(1);
        this.count = 0;
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
            this.count--;
        }
    }

    addCount() {
        this.count++;
    }

    getCount() {
        return this.count;
    }
}

var hitBricks = function(grid, hits) {
    const m = grid.length, n = grid[0].length;
    const uf = new UnionFind(m * n + 1);
    const directions = [[0, 1], [1, 0], [0, -1], [-1, 0]];

    const isValid = (x, y) => x >= 0 && x < m && y >= 0 && y < n;
    const index = (x, y) => x * n + y;

    for (const [x, y] of hits) {
        if (grid[x][y] === 1) {
            grid[x][y] = 0;
        }
    }

    for (let j = 0; j < n; j++) {
        if (grid[0][j] === 1) {
            uf.union(index(0, j), m * n);
        }
    }

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === 1) {
                for (const [dx, dy] of directions) {
                    const ni = i + dx, nj = j + dy;
                    if (isValid(ni, nj) && grid[ni][nj] === 1) {
                        uf.union(index(i, j), index(ni, nj));
                    }
                }
            }
        }
    }

    const result = new Array(hits.length).fill(0);

    for (let k = hits.length - 1; k >= 0; k--) {
        const [x, y] = hits[k];
        if (grid[x][y] === 0) {
            grid[x][y] = 1;
            if (x === 0) {
                uf.union(index(x, y), m * n);
            }
            for (const [dx, dy] of directions) {
                const ni = x + dx, nj = y + dy;
                if (isValid(ni, nj) && grid[ni][nj] === 1) {
                    uf.union(index(x, y), index(ni, nj));
                }
            }
            const count = uf.getCount();
            result[k] = Math.max(0, uf.getCount() - count - 1);
            uf.addCount();
        }
    }

    return result;
};