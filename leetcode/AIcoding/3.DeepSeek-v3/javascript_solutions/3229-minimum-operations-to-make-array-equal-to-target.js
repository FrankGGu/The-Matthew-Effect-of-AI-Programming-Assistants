var minOperations = function(nums, target) {
    let count = 0;
    for (let i = 0; i < nums.length; i++) {
        count += Math.abs(nums[i] - target[i]);
    }
    return count;
};