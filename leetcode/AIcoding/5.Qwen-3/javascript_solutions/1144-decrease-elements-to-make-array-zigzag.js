function minMovesToMakeZigzag(nums) {
    const n = nums.length;
    if (n <= 2) return 0;

    let moves1 = 0, moves2 = 0;

    for (let i = 0; i < n; i += 2) {
        if (i > 0 && nums[i] >= nums[i - 1]) {
            moves1 += nums[i] - nums[i - 1] + 1;
            nums[i] = nums[i - 1] - 1;
        }
        if (i < n - 1 && nums[i] >= nums[i + 1]) {
            moves1 += nums[i] - nums[i + 1] + 1;
            nums[i] = nums[i + 1] - 1;
        }
    }

    for (let i = 1; i < n; i += 2) {
        if (i > 0 && nums[i] >= nums[i - 1]) {
            moves2 += nums[i] - nums[i - 1] + 1;
            nums[i] = nums[i - 1] - 1;
        }
        if (i < n - 1 && nums[i] >= nums[i + 1]) {
            moves2 += nums[i] - nums[i + 1] + 1;
            nums[i] = nums[i + 1] - 1;
        }
    }

    return Math.min(moves1, moves2);
}