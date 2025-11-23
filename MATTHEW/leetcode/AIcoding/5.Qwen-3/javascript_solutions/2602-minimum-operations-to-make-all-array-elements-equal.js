function minOperations(nums) {
    const n = nums.length;
    let operations = 0;
    for (let i = 1; i < n; i++) {
        if (nums[i] !== nums[0]) {
            operations += Math.abs(nums[i] - nums[0]);
        }
    }
    return operations;
}