var maximumSegmentSum = function(nums, removeQueries) {
    const n = nums.length;
    const uf = new UnionFind(n);
    const sums = new Array(n).fill(0);
    const ans = new Array(n);
    let max = 0;

    for (let i = n - 1; i >= 0; i--) {
        ans[i] = max;
        const index = removeQueries[i];
        sums[index] = nums[index];
        max = Math.max(max, sums[index]);

        if (index > 0 && sums[index - 1] !== 0) {
            max = Math.max(max, uf.union(index, index - 1));
        }
        if (index < n - 1 && sums[index + 1] !== 0) {
            max = Math.max(max, uf.union(index, index + 1));
        }
    }

    return ans;

    function UnionFind(n) {
        this.parent = new Array(n).fill(0).map((_, i) => i);
        this.size = new Array(n).fill(0);

        this.find = function(x) {
            if (this.parent[x] !== x) {
                this.parent[x] = this.find(this.parent[x]);
            }
            return this.parent[x];
        }

        this.union = function(x, y) {
            const rootX = this.find(x);
            const rootY = this.find(y);

            if (rootX !== rootY) {
                this.parent[rootX] = rootY;
                this.size[rootY] += sums[rootX] + sums[rootY];
                sums[rootY] = this.size[rootY];
                return this.size[rootY];
            }
            return sums[rootY];
        }
    }
};