var waysToPartition = function(nums) {
    const totalSum = nums.reduce((a, b) => a + b, 0);
    const prefixSum = new Map();
    let currentSum = 0;
    let count = 0;

    for (let num of nums) {
        currentSum += num;
        if (currentSum * 2 === totalSum) count++;
        prefixSum.set(currentSum, (prefixSum.get(currentSum) || 0) + 1);
    }

    currentSum = 0;
    for (let num of nums) {
        currentSum += num;
        const target = totalSum - currentSum;

        if (prefixSum.has(target)) {
            count += prefixSum.get(target);
        }

        if (currentSum * 2 === totalSum) count--;
    }

    return count;
};