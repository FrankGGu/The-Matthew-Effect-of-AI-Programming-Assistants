var reductionOperations = function(nums) {
    nums.sort((a, b) => a - b);
    let operations = 0;
    for (let i = 1; i < nums.length; i++) {
        if (nums[i] !== nums[i - 1]) {
            operations += i;
        }
    }
    return operations;
};