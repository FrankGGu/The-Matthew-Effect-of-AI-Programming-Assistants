var minOperations = function(nums, k) {
    let operations = 0;
    for (let i = 0; i < nums.length; i++) {
        operations += Math.abs(nums[i] - k);
    }
    return operations;
};