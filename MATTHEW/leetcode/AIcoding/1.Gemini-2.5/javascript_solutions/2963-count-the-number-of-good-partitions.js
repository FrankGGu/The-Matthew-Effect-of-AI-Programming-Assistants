var countGoodPartitions = function(nums) {
    const n = nums.length;
    const MOD = 1000000007;

    const lastOccurrence = new Map();
    for (let i = 0; i < n; i++) {
        lastOccurrence.set(nums[i], i);
    }

    let numBlocks = 0;
    let currentMaxReach = 0;
    let i = 0;
    while (i < n) {
        currentMaxReach = Math.max(currentMaxReach, lastOccurrence.get(nums[i]));
        if (i === currentMaxReach) {
            numBlocks++;
        }
        i++;
    }

    const power = (base, exp) => {
        let res = 1;
        base %= MOD;
        while (exp > 0) {
            if (exp % 2 === 1) res = (res * base) % MOD;
            base = (base * base) % MOD;
            exp = Math.floor(exp / 2);
        }
        return res;
    };

    return power(2, numBlocks - 1);
};