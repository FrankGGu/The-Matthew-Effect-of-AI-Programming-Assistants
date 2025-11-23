class DSU {
    constructor(n) {
        this.parent = Array(n).fill(0).map((_, i) => i);
        this.numComponents = n;
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
            this.numComponents--;
            return true;
        }
        return false;
    }
}

var removeStones = function(stones) {
    const n = stones.length;
    if (n <= 1) {
        return 0;
    }

    const dsu = new DSU(n);

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            if (stones[i][0] === stones[j][0] || stones[i][1] === stones[j][1]) {
                dsu.union(i, j);
            }
        }
    }

    return n - dsu.numComponents;
};