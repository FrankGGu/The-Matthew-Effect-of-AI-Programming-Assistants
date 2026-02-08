var gcdSort = function(nums) {
    const n = nums.length;
    const maxVal = Math.max(...nums);
    const uf = new UnionFind(maxVal + 1);

    function findFactors(num) {
        const factors = new Set();
        for (let i = 2; i * i <= num; i++) {
            if (num % i === 0) {
                factors.add(i);
                while (num % i === 0) {
                    num /= i;
                }
            }
        }
        if (num > 1) {
            factors.add(num);
        }
        return factors;
    }

    for (const num of nums) {
        const factors = findFactors(num);
        for (const factor of factors) {
            uf.union(nums[0], factor);
            break;
        }
        for (const factor of factors) {
            uf.union(nums[0], factor);
        }
    }

    const sortedNums = [...nums].sort((a, b) => a - b);
    for (let i = 0; i < n; i++) {
        if (!uf.isConnected(nums[i], sortedNums[i])) {
            return false;
        }
    }

    return true;

    function UnionFind(size) {
        this.parent = Array(size);
        for (let i = 0; i < size; i++) {
            this.parent[i] = i;
        }

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
            }
        }

        this.isConnected = function(x, y) {
            return this.find(x) === this.find(y);
        }
    }
};