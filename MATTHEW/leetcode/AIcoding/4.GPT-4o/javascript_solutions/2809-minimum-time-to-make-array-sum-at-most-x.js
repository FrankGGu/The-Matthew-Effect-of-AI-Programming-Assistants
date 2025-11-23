function minOperations(nums, x) {
    const target = nums.reduce((a, b) => a + b, 0) - x;
    if (target < 0) return -1;

    let maxLength = -1, currentSum = 0, left = 0;

    for (let right = 0; right < nums.length; right++) {
        currentSum += nums[right];

        while (currentSum > target) {
            currentSum -= nums[left++];
        }

        if (currentSum === target) {
            maxLength = Math.max(maxLength, right - left + 1);
        }
    }

    return maxLength === -1 ? -1 : nums.length - maxLength;
}