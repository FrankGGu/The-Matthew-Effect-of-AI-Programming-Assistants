var maximumBeauty = function(nums, k) {
    nums.sort((a, b) => a - b);
    let left = 0;
    let max = 0;
    for (let right = 0; right < nums.length; right++) {
        while (nums[right] - nums[left] > 2 * k) {
            left++;
        }
        max = Math.max(max, right - left + 1);
    }
    return max;
};