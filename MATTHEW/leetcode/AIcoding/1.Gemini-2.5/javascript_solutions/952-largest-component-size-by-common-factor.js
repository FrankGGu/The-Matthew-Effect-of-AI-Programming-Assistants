class DSU {
    constructor(n) {
        this.parent = new Array(n);
        for (let i = 0; i < n; i++) {
            this.parent[i] = i;
        }
        this.rank = new Array(n).fill(0);
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
            if (this.rank[rootI] < this.rank[rootJ]) {
                this.parent[rootI] = rootJ;
            } else if (this.rank[rootI] > this.rank[rootJ]) {
                this.parent[rootJ] = rootI;
            } else {
                this.parent[rootJ] = rootI;
                this.rank[rootI]++;
            }
            return true;
        }
        return false;
    }
}

function getPrimeFactors(n) {
    const factors = new Set();
    if (n <= 1) return factors;

    let d = 2;
    let tempN = n;
    while (d * d <= tempN) {
        if (tempN % d === 0) {
            factors.add(d);
            while (tempN % d === 0) {
                tempN /= d;
            }
        }
        d++;
    }
    if (tempN > 1) {
        factors.add(tempN);
    }
    return factors;
}

var largestComponentSize = function(nums) {
    let maxVal = 0;
    for (const num of nums) {
        maxVal = Math.max(maxVal, num);
    }

    const dsu = new DSU(maxVal + 1);

    for (const num of nums) {
        const factors = getPrimeFactors(num);
        for (const factor of factors) {
            dsu.union(num, factor);
        }
    }

    const componentSizes = new Map();
    let maxComponentSize = 0;

    for (const num of nums) {
        const root = dsu.find(num);
        componentSizes.set(root, (componentSizes.get(root) || 0) + 1);
        maxComponentSize = Math.max(maxComponentSize, componentSizes.get(root));
    }

    return maxComponentSize;
};