var numSubarraysWithSum = function(nums, goal) {
    let count = 0;
    let currentSum = 0;
    const prefixSumCount = new Map();
    prefixSumCount.set(0, 1);

    for (const num of nums) {
        currentSum += num;
        if (prefixSumCount.has(currentSum - goal)) {
            count += prefixSumCount.get(currentSum - goal);
        }
        prefixSumCount.set(currentSum, (prefixSumCount.get(currentSum) || 0) + 1);
    }

    return count;
};