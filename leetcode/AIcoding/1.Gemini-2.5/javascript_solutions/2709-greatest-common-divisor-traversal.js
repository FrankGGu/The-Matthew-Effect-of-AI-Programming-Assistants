const MAX_NUM_VAL = 100000;
const spf = new Array(MAX_NUM_VAL + 1);

(function precomputeSieve() {
    for (let i = 0; i <= MAX_NUM_VAL; i++) {
        spf[i] = i;
    }

    for (let i = 2; i * i <= MAX_NUM_VAL; i++) {
        if (spf[i] === i) {
            for (let j = i * i; j <= MAX_NUM_VAL; j += i) {
                if (spf[j] === j) {
                    spf[j] = i;
                }
            }
        }
    }
})();

class DSU {
    constructor(n) {
        this.parent = Array.from({ length: n }, (_, i) => i);
        this.count = n;
    }

    find(i) {
        if (this.parent[i] === i) {
            return i;
        }
        return this.parent[i] = this.find(this.parent[i]);
    }

    union(i, j) {
        let rootI = this.find(i);
        let rootJ = this.find(j);

        if (rootI !== rootJ) {
            this.parent[rootJ] = rootI;
            this.count--;
            return true;
        }
        return false;
    }
}

function getPrimeFactorsOptimized(n) {
    const factors = new Set();
    if (n <= 1) return factors;

    let tempN = n;
    while (tempN > 1) {
        factors.add(spf[tempN]);
        tempN /= spf[tempN];
    }
    return factors;
}

var gcdTraversal = function(nums) {
    const n = nums.length;

    if (n === 1) {
        return true;
    }

    let hasOne = false;
    for (const num of nums) {
        if (num === 1) {
            hasOne = true;
            break;
        }
    }
    if (hasOne) {
        return false;
    }

    const dsu = new DSU(n);
    const primeToIdxMap = new Map();

    for (let i = 0; i < n; i++) {
        const num = nums[i];
        const factors = getPrimeFactorsOptimized(num);

        for (const factor of factors) {
            if (primeToIdxMap.has(factor)) {
                dsu.union(i, primeToIdxMap.get(factor));
            } else {
                primeToIdxMap.set(factor, i);
            }
        }
    }

    return dsu.count === 1;
};