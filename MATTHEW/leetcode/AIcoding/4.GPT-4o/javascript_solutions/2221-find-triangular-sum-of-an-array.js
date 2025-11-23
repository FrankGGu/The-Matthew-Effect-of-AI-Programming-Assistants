function triangularSum(nums) {
    const n = nums.length;
    for (let i = 1; i < n; i++) {
        for (let j = 0; j < n - i; j++) {
            nums[j] = (nums[j] + nums[j + 1]) % 10;
        }
    }
    return nums[0];
}