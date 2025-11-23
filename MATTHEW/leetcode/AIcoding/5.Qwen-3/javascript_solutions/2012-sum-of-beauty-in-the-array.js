function minDifference(nums) {
    const n = nums.length;
    if (n <= 4) return 0;
    nums.sort((a, b) => a - b);
    return Math.min(
        nums[n - 4] - nums[0],
        nums[n - 3] - nums[1],
        nums[n - 2] - nums[2]
    );
}