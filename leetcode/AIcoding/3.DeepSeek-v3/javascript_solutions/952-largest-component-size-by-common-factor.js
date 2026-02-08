class UnionFind {
    constructor(size) {
        this.parent = new Array(size).fill(0).map((_, i) => i);
        this.rank = new Array(size).fill(0);
    }

    find(x) {
        if (this.parent[x] !== x) {
            this.parent[x] = this.find(this.parent[x]);
        }
        return this.parent[x];
    }

    union(x, y) {
        let rootX = this.find(x);
        let rootY = this.find(y);
        if (rootX === rootY) return;
        if (this.rank[rootX] > this.rank[rootY]) {
            this.parent[rootY] = rootX;
        } else if (this.rank[rootX] < this.rank[rootY]) {
            this.parent[rootX] = rootY;
        } else {
            this.parent[rootY] = rootX;
            this.rank[rootX]++;
        }
    }
}

function largestComponentSize(nums) {
    const maxNum = Math.max(...nums);
    const uf = new UnionFind(maxNum + 1);

    for (const num of nums) {
        for (let i = 2; i * i <= num; i++) {
            if (num % i === 0) {
                uf.union(num, i);
                uf.union(num, num / i);
            }
        }
    }

    const countMap = new Map();
    let maxSize = 0;
    for (const num of nums) {
        const root = uf.find(num);
        const count = (countMap.get(root) || 0) + 1;
        countMap.set(root, count);
        maxSize = Math.max(maxSize, count);
    }

    return maxSize;
}