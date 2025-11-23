function maximumBeauty(nums, k) {
    nums.sort((a, b) => a - b);
    let maxBeauty = 0, n = nums.length, left = 0;

    for (let right = 0; right < n; right++) {
        while (nums[right] - nums[left] > 2 * k) {
            left++;
        }
        maxBeauty = Math.max(maxBeauty, right - left + 1);
    }

    return maxBeauty;
}