function minOperations(nums) {
    let operations = 0;
    for (let i = 1; i < nums.length; i++) {
        if (nums[i] <= nums[i - 1]) {
            let increment = nums[i - 1] - nums[i] + 1;
            nums[i] += increment;
            operations += increment;
        }
    }
    return operations;
}