function minOperations(nums, x) {
    const total = nums.reduce((a, b) => a + b, 0);
    const target = total - x;
    let left = 0, currentSum = 0, maxLen = -1;

    for (let right = 0; right < nums.length; right++) {
        currentSum += nums[right];

        while (currentSum > target && left <= right) {
            currentSum -= nums[left];
            left++;
        }

        if (currentSum === target) {
            maxLen = Math.max(maxLen, right - left + 1);
        }
    }

    return maxLen === -1 ? -1 : nums.length - maxLen;
}