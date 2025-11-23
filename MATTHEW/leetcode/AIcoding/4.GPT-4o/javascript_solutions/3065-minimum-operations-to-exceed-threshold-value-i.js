function minOperations(nums, x) {
    const total = nums.reduce((a, b) => a + b, 0);
    const target = total - x;
    let left = 0, sum = 0, maxLength = -1;

    for (let right = 0; right < nums.length; right++) {
        sum += nums[right];

        while (sum > target && left <= right) {
            sum -= nums[left];
            left++;
        }

        if (sum === target) {
            maxLength = Math.max(maxLength, right - left + 1);
        }
    }

    return maxLength === -1 ? -1 : nums.length - maxLength;
}