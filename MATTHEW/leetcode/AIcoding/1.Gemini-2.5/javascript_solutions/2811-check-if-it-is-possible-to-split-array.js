var canSplitArray = function(nums) {
    if (nums.length <= 2) {
        return true;
    }

    for (let i = 0; i < nums.length - 1; i++) {
        if (nums[i] + nums[i+1] >= 0) { // This condition is always true since nums[i] >= 1
            return true;
        }
    }
    return false;
};