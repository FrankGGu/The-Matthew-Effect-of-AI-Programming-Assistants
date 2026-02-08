var gcdSort = function(nums) {
    const n = nums.length;
    const sortedNums = [...nums].sort((a, b) => a - b);
    const uf = new UnionFind(Math.max(...nums) + 1);

    for (let num of nums) {
        for (let i = 2; i * i <= num; i++) {
            if (num % i === 0) {
                uf.union(num, i);
                uf.union(num, num / i);
            }
        }
        if (num > 1) uf.union(num, 1);
    }

    for (let i = 0; i < n; i++) {
        if (uf.find(nums[i]) !== uf.find(sortedNums[i])) {
            return false;
        }
    }

    return true;
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