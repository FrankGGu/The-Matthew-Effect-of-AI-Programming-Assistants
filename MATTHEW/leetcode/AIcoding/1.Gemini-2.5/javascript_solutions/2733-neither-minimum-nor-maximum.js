var findNonMinMax = function(nums) {
    if (nums.length <= 2) {
        return -1;
    }

    nums.sort((a, b) => a - b);

    return nums[1];
};