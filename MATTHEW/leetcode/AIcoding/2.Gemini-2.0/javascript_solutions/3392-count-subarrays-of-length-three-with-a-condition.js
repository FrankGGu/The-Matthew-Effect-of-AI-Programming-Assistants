var countGoodSubarrays = function(nums, k) {
    let count = 0;
    for (let i = 0; i <= nums.length - 3; i++) {
        if (Math.abs(nums[i] - nums[i + 1]) <= k &&
            Math.abs(nums[i + 1] - nums[i + 2]) <= k &&
            Math.abs(nums[i] - nums[i + 2]) <= k) {
            count++;
        }
    }
    return count;
};