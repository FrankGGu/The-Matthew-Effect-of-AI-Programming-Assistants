var maximumBeauty = function(nums, k) {
    nums.sort((a, b) => a - b);

    let maxBeauty = 0;
    let left = 0;

    for (let right = 0; right < nums.length; right++) {
        while (nums[right] - nums[left] > 2 * k) {
            left++;
        }
        maxBeauty = Math.max(maxBeauty, right - left + 1);
    }

    return maxBeauty;
};