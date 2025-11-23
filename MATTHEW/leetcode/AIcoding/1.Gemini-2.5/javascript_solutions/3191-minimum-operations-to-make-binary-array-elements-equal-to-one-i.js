var minOperations = function(nums) {
    let operations = 0;
    const n = nums.length;

    for (let i = 0; i < n; i++) {
        if (nums[i] === 0) {
            if (i + 2 >= n) {
                return -1;
            }

            nums[i] = 1 - nums[i];
            nums[i+1] = 1 - nums[i+1];
            nums[i+2] = 1 - nums[i+2];

            operations++;
        }
    }

    return operations;
};