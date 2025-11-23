function minOperations(nums, k) {
    const prefixSum = new Array(nums.length).fill(0);
    prefixSum[0] = nums[0];
    for (let i = 1; i < nums.length; i++) {
        prefixSum[i] = prefixSum[i - 1] + nums[i];
    }

    const remainderCount = new Map();
    remainderCount.set(0, 1);
    let result = 0;
    let currentRemainder = 0;

    for (let i = 0; i < nums.length; i++) {
        currentRemainder = (currentRemainder + prefixSum[i]) % k;
        if (currentRemainder < 0) currentRemainder += k;
        if (remainderCount.has(currentRemainder)) {
            result += remainderCount.get(currentRemainder);
        }
        remainderCount.set(currentRemainder, (remainderCount.get(currentRemainder) || 0) + 1);
    }

    return result;
}