var smallestRangeII = function(nums, k) {
    nums.sort((a, b) => a - b);
    const n = nums.length;
    let res = nums[n - 1] - nums[0];

    for (let i = 0; i < n - 1; i++) {
        const max = Math.max(nums[i] + k, nums[n - 1] - k);
        const min = Math.min(nums[0] + k, nums[i + 1] - k);
        res = Math.min(res, max - min);
    }

    return res;
};