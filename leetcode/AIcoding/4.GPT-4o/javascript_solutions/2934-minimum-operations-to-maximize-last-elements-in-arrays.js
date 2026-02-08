var minimumOperations = function(nums, x) {
    let total = nums.reduce((a, b) => a + b, 0);
    let target = total - x;

    if (target < 0) return -1;

    let maxLength = -1;
    let sum = 0;
    let left = 0;

    for (let right = 0; right < nums.length; right++) {
        sum += nums[right];

        while (sum > target) {
            sum -= nums[left];
            left++;
        }

        if (sum === target) {
            maxLength = Math.max(maxLength, right - left + 1);
        }
    }

    return maxLength === -1 ? -1 : nums.length - maxLength;
};