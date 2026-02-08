var minOperations = function(nums, x) {
    let target = nums.reduce((a, b) => a + b, 0) - x;
    let maxLength = -1;
    let currentSum = 0;
    let left = 0;

    for (let right = 0; right < nums.length; right++) {
        currentSum += nums[right];

        while (currentSum > target && left <= right) {
            currentSum -= nums[left];
            left++;
        }

        if (currentSum === target) {
            maxLength = Math.max(maxLength, right - left + 1);
        }
    }

    return maxLength === -1 ? -1 : nums.length - maxLength;
};