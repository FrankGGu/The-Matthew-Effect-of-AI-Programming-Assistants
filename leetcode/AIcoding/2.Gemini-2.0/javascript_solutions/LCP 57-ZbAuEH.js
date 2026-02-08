var hitBricks = function(hits, width, height) {
    const grid = Array(height).fill(null).map(() => Array(width).fill(1));
    for (const [row, col] of hits) {
        grid[row][col] = 0;
    }

    const uf = new UnionFind(width * height + 1);
    const dummyNode = width * height;

    for (let i = 0; i < height; i++) {
        for (let j = 0; j < width; j++) {
            if (grid[i][j] === 1) {
                if (i === 0) {
                    uf.union(j, dummyNode);
                }

                if (i > 0 && grid[i - 1][j] === 1) {
                    uf.union(i * width + j, (i - 1) * width + j);
                }

                if (j > 0 && grid[i][j - 1] === 1) {
                    uf.union(i * width + j, i * width + (j - 1));
                }
            }
        }
    }

    const res = [];
    const directions = [[0, 1], [0, -1], [1, 0], [-1, 0]];

    for (let i = hits.length - 1; i >= 0; i--) {
        const [row, col] = hits[i];
        if (grid[row][col] === 0) {
            grid[row][col] = 1;

            let prev = uf.getSize(dummyNode);

            if (row === 0) {
                uf.union(col, dummyNode);
            }

            for (const [dr, dc] of directions) {
                const newRow = row + dr;
                const newCol = col + dc;

                if (newRow >= 0 && newRow < height && newCol >= 0 && newCol < width && grid[newRow][newCol] === 1) {
                    uf.union(row * width + col, newRow * width + newCol);
                }
            }

            let curr = uf.getSize(dummyNode);
            res.push(Math.max(0, curr - prev - 1));
        } else {
            res.push(0);
        }
    }

    return res.reverse();

    function UnionFind(n) {
        this.parent = Array(n).fill(0).map((_, i) => i);
        this.size = Array(n).fill(1);

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