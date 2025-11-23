var maxFrequency = function(nums, k) {
    nums.sort((a, b) => a - b);
    let left = 0;
    let right = 0;
    let sum = 0;
    let maxLen = 0;

    while (right < nums.length) {
        sum += nums[right];

        while ((right - left + 1) * nums[right] - sum > k) {
            sum -= nums[left];
            left++;
        }

        maxLen = Math.max(maxLen, right - left + 1);
        right++;
    }

    return maxLen;
};