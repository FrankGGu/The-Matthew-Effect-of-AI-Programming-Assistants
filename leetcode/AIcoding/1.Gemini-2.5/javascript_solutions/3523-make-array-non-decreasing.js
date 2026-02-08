var minOperations = function(nums) {
    let operations = 0;
    for (let i = 1; i < nums.length; i++) {
        if (nums[i] <= nums[i - 1]) {
            let diff = (nums[i - 1] + 1) - nums[i];
            operations += diff;
            nums[i] = nums[i - 1] + 1;
        }
    }
    return operations;
};