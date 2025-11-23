var maxBalancedSubsequenceSum = function(nums) {
    const n = nums.length;
    const sorted = [...nums].sort((a, b) => a - b);
    const rank = new Map();
    let compressed = 0;
    for (let i = 0; i < n; i++) {
        if (i === 0 || sorted[i] !== sorted[i - 1]) {
            rank.set(sorted[i], ++compressed);
        }
    }

    class FenwickTree {
        constructor(size) {
            this.size = size;
            this.tree = Array(size + 1).fill(-Infinity);
        }
        update(index, value) {
            while (index <= this.size) {
                this.tree[index] = Math.max(this.tree[index], value);
                index += index & -index;
            }
        }
        query(index) {
            let res = -Infinity;
            while (index > 0) {
                res = Math.max(res, this.tree[index]);
                index -= index & -index;
            }
            return res;
        }
    }

    const ft = new FenwickTree(compressed);
    let res = -Infinity;
    for (let i = 0; i < n; i++) {
        const num = nums[i];
        const r = rank.get(num);
        const maxSum = Math.max(ft.query(r), 0) + num;
        res = Math.max(res, maxSum);
        ft.update(r, maxSum);
    }
    return res;
};