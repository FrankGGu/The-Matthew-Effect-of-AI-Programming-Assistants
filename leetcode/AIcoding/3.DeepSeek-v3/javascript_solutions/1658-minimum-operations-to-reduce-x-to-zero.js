var minOperations = function(nums, x) {
    const totalSum = nums.reduce((a, b) => a + b, 0);
    const target = totalSum - x;
    if (target < 0) return -1;
    if (target === 0) return nums.length;

    let left = 0, currentSum = 0, maxLength = -1;
    for (let right = 0; right < nums.length; right++) {
        currentSum += nums[right];
        while (currentSum > target) {
            currentSum -= nums[left];
            left++;
        }
        if (currentSum === target) {
            maxLength = Math.max(maxLength, right - left + 1);
        }
    }

    return maxLength === -1 ? -1 : nums.length - maxLength;
};