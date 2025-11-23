var subarraySum = function(nums, k) {
    let count = 0;
    let currentSum = 0;
    const sumMap = new Map();
    sumMap.set(0, 1);

    for (let i = 0; i < nums.length; i++) {
        currentSum += nums[i];
        if (sumMap.has(currentSum - k)) {
            count += sumMap.get(currentSum - k);
        }
        sumMap.set(currentSum, (sumMap.get(currentSum) || 0) + 1);
    }

    return count;
};