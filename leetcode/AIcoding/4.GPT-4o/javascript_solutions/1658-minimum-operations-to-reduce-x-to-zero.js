function minOperations(nums, x) {
    const total = nums.reduce((a, b) => a + b, 0);
    const target = total - x;
    let maxLength = -1;
    let currentSum = 0;
    const map = new Map();
    map.set(0, -1);

    for (let i = 0; i < nums.length; i++) {
        currentSum += nums[i];
        if (map.has(currentSum - target)) {
            maxLength = Math.max(maxLength, i - map.get(currentSum - target));
        }
        map.set(currentSum, i);
    }

    return maxLength === -1 ? -1 : nums.length - maxLength;
}