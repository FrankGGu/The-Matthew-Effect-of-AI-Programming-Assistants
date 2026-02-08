class DSU {
    constructor(n) {
        this.parent = new Array(n);
        this.rank = new Array(n).fill(0);
        for (let i = 0; i < n; i++) {
            this.parent[i] = i;
        }
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

function sieve(maxVal) {
    const spf = new Array(maxVal + 1);
    for (let i = 0; i <= maxVal; i++) {
        spf[i] = i;
    }

    for (let i = 2; i * i <= maxVal; i++) {
        if (spf[i] === i) { 
            for (let j = i * i; j <= maxVal; j += i) {
                if (spf[j] === j) {
                    spf[j] = i;
                }
            }
        }
    }
    return spf;
}

function getPrimeFactors(num, spf) {
    const factors = new Set();
    while (num > 1) {
        factors.add(spf[num]);
        num = Math.floor(num / spf[num]);
    }
    return Array.from(factors);
}

var gcdSort = function(nums) {
    const n = nums.length;
    if (n <= 1) {
        return true;
    }

    let maxNum = 0;
    for (const num of nums) {
        maxNum = Math.max(maxNum, num);
    }

    const spf = sieve(maxNum);
    const dsu = new DSU(maxNum + 1);

    for (const num of nums) {
        if (num === 1) continue; 
        const factors = getPrimeFactors(num, spf);
        for (const factor of factors) {
            dsu.union(num, factor);
        }
    }

    const sortedNums = [...nums].sort((a, b) => a - b);

    for (let i = 0; i < n; i++) {
        if (dsu.find(nums[i]) !== dsu.find(sortedNums[i])) {
            return false;
        }
    }

    return true;
};