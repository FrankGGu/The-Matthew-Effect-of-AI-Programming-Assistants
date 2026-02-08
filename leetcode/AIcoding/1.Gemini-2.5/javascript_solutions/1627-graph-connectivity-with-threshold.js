class DSU {
    constructor(n) {
        this.parent = Array(n + 1).fill(0).map((_, i) => i);
    }

    find(i) {
        if (this.parent[i] === i) {
            return i;
        }
        return this.parent[i] = this.find(this.parent[i]);
    }

    union(i, j) {
        const rootI = this.find(i);
        const rootJ = this.find(j);
        if (rootI !== rootJ) {
            this.parent[rootJ] = rootI;
            return true;
        }
        return false;
    }
}

var areConnected = function(n, threshold, queries) {
    const dsu = new DSU(n);

    for (let g = threshold + 1; g <= n; g++) {
        for (let m = g; m <= n; m += g) {
            if (m + g <= n) {
                dsu.union(m, m + g);
            }
        }
    }

    const results = [];
    for (const [city1, city2] of queries) {
        results.push(dsu.find(city1) === dsu.find(city2));
    }

    return results;
};