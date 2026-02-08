var divideArray = function(nums, k) {
    nums.sort((a, b) => a - b);
    const result = [];
    const n = nums.length;

    for (let i = 0; i < n; i += 3) {
        if (nums[i + 2] - nums[i] > k) {
            return [];
        }
        result.push([nums[i], nums[i + 1], nums[i + 2]]);
    }

    return result;
};