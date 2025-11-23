var minOperations = function(nums, k) {
    nums.sort((a, b) => a - b);
    let operations = 0;
    let i = 0;
    while (nums.length > 1 && nums[0] < k) {
        nums.push(Math.min(k, nums[0] * 2 + nums[1]));
        nums.shift();
        nums.shift();
        nums.sort((a, b) => a - b);
        operations++;
    }

    return operations;
};