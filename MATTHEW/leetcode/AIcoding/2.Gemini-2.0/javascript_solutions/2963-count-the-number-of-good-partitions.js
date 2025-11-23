var numberOfGoodPartitions = function(nums) {
    const lastOccurrence = new Map();
    for (let i = 0; i < nums.length; i++) {
        lastOccurrence.set(nums[i], i);
    }

    let count = 0;
    let maxIndex = -1;
    let currentMax = -1;

    for (let i = 0; i < nums.length; i++) {
        currentMax = Math.max(currentMax, lastOccurrence.get(nums[i]));
        if (i === currentMax) {
            count++;
        }
    }

    if (count === 0) return 0;

    const MOD = 10**9 + 7;
    let result = 1;
    for (let i = 1; i < count; i++) {
        result = (result * 2) % MOD;
    }

    return result;
};