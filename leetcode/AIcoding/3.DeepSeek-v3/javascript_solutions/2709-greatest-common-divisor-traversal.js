const gcd = (a, b) => {
    while (b !== 0) {
        let temp = b;
        b = a % b;
        a = temp;
    }
    return a;
};

class UnionFind {
    constructor(size) {
        this.parent = Array(size).fill(0).map((_, i) => i);
        this.rank = Array(size).fill(0);
    }

    find(u) {
        if (this.parent[u] !== u) {
            this.parent[u] = this.find(this.parent[u]);
        }
        return this.parent[u];
    }

    union(u, v) {
        let rootU = this.find(u);
        let rootV = this.find(v);
        if (rootU === rootV) return;
        if (this.rank[rootU] > this.rank[rootV]) {
            this.parent[rootV] = rootU;
        } else if (this.rank[rootU] < this.rank[rootV]) {
            this.parent[rootU] = rootV;
        } else {
            this.parent[rootV] = rootU;
            this.rank[rootU]++;
        }
    }
}

var canTraverseAllPairs = function(nums) {
    if (nums.length === 1) return true;

    const maxNum = Math.max(...nums);
    const uf = new UnionFind(nums.length);
    const primeToIndex = new Map();

    for (let i = 0; i < nums.length; i++) {
        let num = nums[i];
        if (num === 1) return false;

        for (let p = 2; p * p <= num; p++) {
            if (num % p === 0) {
                if (primeToIndex.has(p)) {
                    uf.union(i, primeToIndex.get(p));
                } else {
                    primeToIndex.set(p, i);
                }
                while (num % p === 0) {
                    num /= p;
                }
            }
        }
        if (num > 1) {
            if (primeToIndex.has(num)) {
                uf.union(i, primeToIndex.get(num));
            } else {
                primeToIndex.set(num, i);
            }
        }
    }

    const root = uf.find(0);
    for (let i = 1; i < nums.length; i++) {
        if (uf.find(i) !== root) {
            return false;
        }
    }
    return true;
};