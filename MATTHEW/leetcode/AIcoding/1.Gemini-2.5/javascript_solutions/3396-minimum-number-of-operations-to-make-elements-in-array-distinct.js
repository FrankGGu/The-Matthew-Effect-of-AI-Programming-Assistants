var minIncrementForUnique = function(nums) {
    if (nums.length <= 1) {
        return 0;
    }

    nums.sort((a, b) => a - b);

    let operations = 0;

    for (let i = 1; i < nums.length; i++) {
        if (nums[i] <= nums[i - 1]) {
            let requiredValue = nums[i - 1] + 1;
            operations += (requiredValue - nums[i]);
            nums[i] = requiredValue;
        }
    }

    return operations;
};