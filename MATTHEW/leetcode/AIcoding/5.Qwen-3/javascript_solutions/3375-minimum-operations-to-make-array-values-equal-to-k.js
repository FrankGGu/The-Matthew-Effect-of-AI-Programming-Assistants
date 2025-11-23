function minOperations(nums, k) {
    let operations = 0;
    for (let i = 0; i < nums.length; i++) {
        if (nums[i] > k) {
            operations += nums[i] - k;
        } else if (nums[i] < k) {
            operations += k - nums[i];
        }
    }
    return operations;
}