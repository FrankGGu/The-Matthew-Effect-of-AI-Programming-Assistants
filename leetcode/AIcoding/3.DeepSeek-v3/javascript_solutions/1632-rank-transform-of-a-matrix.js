class UnionFind {
    constructor(size) {
        this.parent = Array(size).fill().map((_, i) => i);
        this.rank = Array(size).fill(0);
    }
    find(x) {
        if (this.parent[x] !== x) {
            this.parent[x] = this.find(this.parent[x]);
        }
        return this.parent[x];
    }
    union(x, y) {
        const xRoot = this.find(x);
        const yRoot = this.find(y);
        if (xRoot === yRoot) return;
        if (this.rank[xRoot] < this.rank[yRoot]) {
            this.parent[xRoot] = yRoot;
        } else if (this.rank[xRoot] > this.rank[yRoot]) {
            this.parent[yRoot] = xRoot;
        } else {
            this.parent[yRoot] = xRoot;
            this.rank[xRoot]++;
        }
    }
}

var matrixRankTransform = function(matrix) {
    const m = matrix.length;
    const n = matrix[0].length;
    const rank = Array(m).fill().map(() => Array(n).fill(0));
    const valuePositions = new Map();

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            const val = matrix[i][j];
            if (!valuePositions.has(val)) {
                valuePositions.set(val, []);
            }
            valuePositions.get(val).push([i, j]);
        }
    }

    const sortedValues = Array.from(valuePositions.keys()).sort((a, b) => a - b);

    const rowMax = Array(m).fill(0);
    const colMax = Array(n).fill(0);

    for (const val of sortedValues) {
        const positions = valuePositions.get(val);
        const uf = new UnionFind(positions.length);

        const rowGroups = new Map();
        const colGroups = new Map();

        for (let k = 0; k < positions.length; k++) {
            const [i, j] = positions[k];
            if (!rowGroups.has(i)) {
                rowGroups.set(i, k);
            } else {
                uf.union(k, rowGroups.get(i));
            }
            if (!colGroups.has(j)) {
                colGroups.set(j, k);
            } else {
                uf.union(k, colGroups.get(j));
            }
        }

        const groups = new Map();
        for (let k = 0; k < positions.length; k++) {
            const root = uf.find(k);
            if (!groups.has(root)) {
                groups.set(root, []);
            }
            groups.get(root).push(k);
        }

        for (const [root, indices] of groups) {
            let maxRank = 0;
            for (const k of indices) {
                const [i, j] = positions[k];
                maxRank = Math.max(maxRank, rowMax[i], colMax[j]);
            }
            const currentRank = maxRank + 1;
            for (const k of indices) {
                const [i, j] = positions[k];
                rank[i][j] = currentRank;
                rowMax[i] = currentRank;
                colMax[j] = currentRank;
            }
        }
    }

    return rank;
};