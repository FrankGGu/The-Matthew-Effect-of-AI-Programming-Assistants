var canSplitArray = function(nums, m) {
    let count = 1;
    for (let i = 1; i < nums.length; i++) {
        if (nums[i] + nums[i - 1] > m) {
            count++;
        }
    }
    return count <= 2;
};