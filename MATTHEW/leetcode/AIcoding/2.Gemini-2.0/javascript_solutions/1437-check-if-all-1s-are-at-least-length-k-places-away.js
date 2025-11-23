var kLengthApart = function(nums, k) {
    let lastOne = -Infinity;
    for (let i = 0; i < nums.length; i++) {
        if (nums[i] === 1) {
            if (i - lastOne <= k) {
                return false;
            }
            lastOne = i;
        }
    }
    return true;
};