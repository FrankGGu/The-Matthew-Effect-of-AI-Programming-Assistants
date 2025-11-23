class FenwickTree {
    constructor(size) {
        this.tree = new Array(size + 1).fill(0);
        this.size = size;
        this.MOD = 1000000007;
    }

    update(idx, val) {
        while (idx <= this.size) {
            this.tree[idx] = (this.tree[idx] + val) % this.MOD;
            idx += idx & (-idx);
        }
    }

    query(idx) {
        let sum = 0;
        while (idx > 0) {
            sum = (sum + this.tree[idx]) % this.MOD;
            idx -= idx & (-idx);
        }
        return sum;
    }
}

var sumOfGoodSubsequences = function(nums) {
    const MOD = 1000000007;
    const n = nums.length;

    if (n === 0) {
        return 0;
    }

    const uniqueNums = [...new Set(nums)].sort((a, b) => a - b);
    const rankMap = new Map();
    for (let i = 0; i < uniqueNums.length; i++) {
        rankMap.set(uniqueNums[i], i + 1);
    }
    const maxRank = uniqueNums.length;

    const bitCount = new FenwickTree(maxRank);
    const bitSum = new FenwickTree(maxRank);

    let totalOverallSum = 0;

    for (let i = 0; i < n; i++) {
        const val = nums[i];
        const rank = rankMap.get(val);

        const prevCountSum = bitCount.query(rank - 1);
        const prevSubsequenceSum = bitSum.query(rank - 1);

        let currentCount = (1 + prevCountSum) % MOD;

        let currentSum = (val + prevSubsequenceSum + (prevCountSum * val) % MOD) % MOD;

        if (currentCount < 0) currentCount += MOD;
        if (currentSum < 0) currentSum += MOD;

        bitCount.update(rank, currentCount);
        bitSum.update(rank, currentSum);

        totalOverallSum = (totalOverallSum + currentSum) % MOD;
        if (totalOverallSum < 0) totalOverallSum += MOD;
    }

    return totalOverallSum;
};