var largestComponentSize = function(nums) {
    const n = nums.length;
    const maxVal = Math.max(...nums);
    const uf = new UnionFind(maxVal + 1);

    for (let num of nums) {
        for (let i = 2; i * i <= num; i++) {
            if (num % i === 0) {
                uf.union(num, i);
                uf.union(num, num / i);
            }
        }
    }

    const counts = new Map();
    let maxCount = 0;
    for (let num of nums) {
        const root = uf.find(num);
        counts.set(root, (counts.get(root) || 0) + 1);
        maxCount = Math.max(maxCount, counts.get(root));
    }

    return maxCount;
};

class UnionFind {
    constructor(n) {
        this.parent = new Array(n);
        for (let i = 0; i < n; i++) {
            this.parent[i] = i;
        }
    }

    find(x) {
        if (this.parent[x] !== x) {
            this.parent[x] = this.find(this.parent[x]);
        }
        return this.parent[x];
    }

    union(x, y) {
        const rootX = this.find(x);
        const rootY = this.find(y);
        if (rootX !== rootY) {
            this.parent[rootX] = rootY;
        }
    }
}