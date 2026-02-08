var minOperations = function(nums, target) {
    let operations = 0;
    let possible = true;

    while (possible) {
        possible = false;
        for (let i = 0; i < nums.length; i++) {
            if (nums[i] > target) {
                operations += nums[i] - target;
                nums[i] = target;
                possible = true;
            }
        }
    }

    return operations;
};