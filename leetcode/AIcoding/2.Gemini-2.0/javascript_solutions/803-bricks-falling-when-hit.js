var hitBricks = function(grid, hits) {
    const m = grid.length;
    const n = grid[0].length;
    const dxy = [[0, 1], [0, -1], [1, 0], [-1, 0]];
    const uf = new UnionFind(m * n + 1);

    function getIndex(r, c) {
        return r * n + c + 1;
    }

    function isValid(r, c) {
        return r >= 0 && r < m && c >= 0 && c < n;
    }

    for (const [r, c] of hits) {
        if (grid[r][c] === 1) {
            grid[r][c] = 2;
        }
    }

    for (let r = 0; r < m; r++) {
        for (let c = 0; c < n; c++) {
            if (grid[r][c] === 1) {
                if (r === 0) {
                    uf.union(0, getIndex(r, c));
                }
                for (const [dx, dy] of dxy) {
                    const nr = r + dx;
                    const nc = c + dy;
                    if (isValid(nr, nc) && grid[nr][nc] === 1) {
                        uf.union(getIndex(r, c), getIndex(nr, nc));
                    }
                }
            }
        }
    }

    const res = new Array(hits.length).fill(0);
    for (let i = hits.length - 1; i >= 0; i--) {
        const [r, c] = hits[i];
        if (grid[r][c] === 2) {
            grid[r][c] = 1;
            let prev = uf.getSize(0);

            if (r === 0) {
                uf.union(0, getIndex(r, c));
            }
            for (const [dx, dy] of dxy) {
                const nr = r + dx;
                const nc = c + dy;
                if (isValid(nr, nc) && grid[nr][nc] === 1) {
                    uf.union(getIndex(r, c), getIndex(nr, nc));
                }
            }

            let curr = uf.getSize(0);
            res[i] = Math.max(0, curr - prev - 1);
        }
    }

    return res;

    function UnionFind(n) {
        this.parent = new Array(n).fill(0).map((_, i) => i);
        this.size = new Array(n).fill(1);

        this.find = function(x) {
            if (this.parent[x] !== x) {
                this.parent[x] = this.find(this.parent[x]);
            }
            return this.parent[x];
        }

        this.union = function(x, y) {
            const rootX = this.find(x);
            const rootY = this.find(y);

            if (rootX !== rootY) {
                this.parent[rootX] = rootY;
                this.size[rootY] += this.size[rootX];
            }
        }

        this.getSize = function(x) {
            return this.size[this.find(x)];
        }
    }
};