class DSU {
    constructor(n) {
        this.parent = Array(n).fill(0).map((_, i) => i);
        this.regions = n;
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
            this.parent[rootJ] = rootI;
            this.regions--;
            return true;
        }
        return false;
    }
}

var regionsBySlashes = function(grid) {
    const N = grid.length;
    const dsu = new DSU(N * N * 4);

    for (let r = 0; r < N; r++) {
        for (let c = 0; c < N; c++) {
            const cellBaseIdx = (r * N + c) * 4;

            const char = grid[r][c];
            if (char === ' ') {
                dsu.union(cellBaseIdx + 0, cellBaseIdx + 1);
                dsu.union(cellBaseIdx + 1, cellBaseIdx + 2);
                dsu.union(cellBaseIdx + 2, cellBaseIdx + 3);
            } else if (char === '/') {
                dsu.union(cellBaseIdx + 0, cellBaseIdx + 3);
                dsu.union(cellBaseIdx + 1, cellBaseIdx + 2);
            } else if (char === '\\') {
                dsu.union(cellBaseIdx + 0, cellBaseIdx + 1);
                dsu.union(cellBaseIdx + 2, cellBaseIdx + 3);
            }

            if (r + 1 < N) {
                dsu.union(cellBaseIdx + 2, ((r + 1) * N + c) * 4 + 0);
            }
            if (c + 1 < N) {
                dsu.union(cellBaseIdx + 1, (r * N + (c + 1)) * 4 + 3);
            }
        }
    }

    return dsu.regions;
};