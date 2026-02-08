var gcdSort = function(nums) {
    const n = nums.length;
    let maxVal = 0;
    for (const num of nums) {
        maxVal = Math.max(maxVal, num);
    }

    const parent = new Array(maxVal + 1).fill(0).map((_, i) => i);
    const rank = new Array(maxVal + 1).fill(0);

    function find(x) {
        if (parent[x] !== x) {
            parent[x] = find(parent[x]);
        }
        return parent[x];
    }

    function union(x, y) {
        const rootX = find(x);
        const rootY = find(y);
        if (rootX !== rootY) {
            if (rank[rootX] < rank[rootY]) {
                parent[rootX] = rootY;
            } else if (rank[rootX] > rank[rootY]) {
                parent[rootY] = rootX;
            } else {
                parent[rootY] = rootX;
                rank[rootX]++;
            }
        }
    }

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
            union(nums[0], factor);
        }
    }

    const sortedNums = [...nums].sort((a, b) => a - b);
    for (let i = 0; i < n; i++) {
        if (find(nums[i]) !== find(sortedNums[i])) {
            return false;
        }
    }

    return true;
};