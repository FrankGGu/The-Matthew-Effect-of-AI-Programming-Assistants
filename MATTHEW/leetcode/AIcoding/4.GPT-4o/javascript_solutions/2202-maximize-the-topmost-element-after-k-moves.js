var maximumTop = function(nums, k) {
    if (k === 0) return nums[0] || -1;
    if (k > nums.length) return Math.max(...nums);

    let max = -1;
    for (let i = 0; i < k - 1 && i < nums.length; i++) {
        max = Math.max(max, nums[i]);
    }

    if (k - 1 < nums.length) {
        max = Math.max(max, nums[k - 1]);
    }

    return max;
};