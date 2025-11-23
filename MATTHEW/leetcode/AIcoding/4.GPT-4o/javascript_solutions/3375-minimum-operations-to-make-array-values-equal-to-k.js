function minOperations(nums, x) {
    const total = nums.reduce((a, b) => a + b, 0);
    const target = total - x;
    let maxLength = -1;
    let currentSum = 0;
    const sumMap = new Map();
    sumMap.set(0, -1);

    for (let i = 0; i < nums.length; i++) {
        currentSum += nums[i];
        if (sumMap.has(currentSum - target)) {
            maxLength = Math.max(maxLength, i - sumMap.get(currentSum - target));
        }
        sumMap.set(currentSum, i);
    }

    return maxLength === -1 ? -1 : nums.length - maxLength;
}