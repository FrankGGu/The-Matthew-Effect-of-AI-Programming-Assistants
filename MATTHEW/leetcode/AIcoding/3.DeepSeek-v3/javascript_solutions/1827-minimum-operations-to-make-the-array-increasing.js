var minOperations = function(nums) {
    let operations = 0;
    for (let i = 1; i < nums.length; i++) {
        if (nums[i] <= nums[i - 1]) {
            const needed = nums[i - 1] + 1;
            operations += needed - nums[i];
            nums[i] = needed;
        }
    }
    return operations;
};