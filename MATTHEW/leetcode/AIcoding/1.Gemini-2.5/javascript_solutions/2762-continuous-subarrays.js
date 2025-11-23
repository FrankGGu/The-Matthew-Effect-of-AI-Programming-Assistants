var subarraySum = function(nums, k) {
    let count = 0;
    let currentSum = 0;
    const sumFrequency = new Map();
    sumFrequency.set(0, 1);

    for (let i = 0; i < nums.length; i++) {
        currentSum += nums[i];
        if (sumFrequency.has(currentSum - k)) {
            count += sumFrequency.get(currentSum - k);
        }
        sumFrequency.set(currentSum, (sumFrequency.get(currentSum) || 0) + 1);
    }

    return count;
};