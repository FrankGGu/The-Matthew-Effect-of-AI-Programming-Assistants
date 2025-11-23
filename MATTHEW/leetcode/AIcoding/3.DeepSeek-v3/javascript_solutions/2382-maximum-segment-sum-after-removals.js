class UnionFind {
    constructor(size) {
        this.parent = new Array(size).fill(-1);
        this.sum = new Array(size).fill(0);
    }

    find(u) {
        if (this.parent[u] < 0) return u;
        this.parent[u] = this.find(this.parent[u]);
        return this.parent[u];
    }

    union(u, v) {
        let rootU = this.find(u);
        let rootV = this.find(v);
        if (rootU === rootV) return;
        if (this.parent[rootU] > this.parent[rootV]) {
            [rootU, rootV] = [rootV, rootU];
        }
        this.parent[rootU] += this.parent[rootV];
        this.parent[rootV] = rootU;
        this.sum[rootU] += this.sum[rootV];
    }

    setSum(u, val) {
        this.sum[u] = val;
    }

    getSum(u) {
        return this.sum[this.find(u)];
    }
}

var maximumSegmentSum = function(nums, removeQueries) {
    const n = nums.length;
    const uf = new UnionFind(n);
    const res = new Array(n).fill(0);
    let maxSum = 0;

    for (let i = removeQueries.length - 1; i >= 0; i--) {
        const pos = removeQueries[i];
        res[i] = maxSum;
        uf.setSum(pos, nums[pos]);
        if (pos > 0 && uf.getSum(pos - 1) > 0) {
            uf.union(pos, pos - 1);
        }
        if (pos < n - 1 && uf.getSum(pos + 1) > 0) {
            uf.union(pos, pos + 1);
        }
        maxSum = Math.max(maxSum, uf.getSum(pos));
    }

    return res;
};