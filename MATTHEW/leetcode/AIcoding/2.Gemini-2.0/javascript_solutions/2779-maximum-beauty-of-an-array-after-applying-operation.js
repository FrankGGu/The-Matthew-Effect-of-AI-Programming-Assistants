var maximumBeauty = function(nums, k) {
    nums.sort((a, b) => a - b);
    let left = 0;
    let maxLen = 0;

    for (let right = 0; right < nums.length; right++) {
        while (nums[right] - nums[left] > 2 * k) {
            left++;
        }
        maxLen = Math.max(maxLen, right - left + 1);
    }

    return maxLen;
};