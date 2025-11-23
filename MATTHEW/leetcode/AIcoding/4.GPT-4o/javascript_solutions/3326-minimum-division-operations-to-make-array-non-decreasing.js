function minOperations(nums) {
    let operations = 0;
    for (let i = 1; i < nums.length; i++) {
        if (nums[i] < nums[i - 1]) {
            operations += Math.ceil((nums[i - 1] - nums[i]) / nums[i]);
            nums[i] = nums[i - 1];
        }
    }
    return operations;
}