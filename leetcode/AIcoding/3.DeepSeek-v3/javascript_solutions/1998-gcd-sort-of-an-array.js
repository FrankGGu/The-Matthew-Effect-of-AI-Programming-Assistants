class UnionFind {
    constructor(size) {
        this.parent = Array(size + 1).fill().map((_, i) => i);
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
            this.parent[rootY] = rootX;
        }
    }
}

function gcdSort(nums) {
    const maxNum = Math.max(...nums);
    const uf = new UnionFind(maxNum);

    for (const num of nums) {
        let x = num;
        for (let i = 2; i * i <= x; i++) {
            if (x % i === 0) {
                uf.union(num, i);
                while (x % i === 0) {
                    x /= i;
                }
            }
        }
        if (x > 1) {
            uf.union(num, x);
        }
    }

    const sortedNums = [...nums].sort((a, b) => a - b);
    for (let i = 0; i < nums.length; i++) {
        if (uf.find(nums[i]) !== uf.find(sortedNums[i])) {
            return false;
        }
    }
    return true;
}