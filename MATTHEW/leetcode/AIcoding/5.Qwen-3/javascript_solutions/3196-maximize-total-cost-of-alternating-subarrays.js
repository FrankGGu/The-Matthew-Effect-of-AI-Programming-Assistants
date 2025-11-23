function maxTotalCost(nums) {
    const n = nums.length;
    let dp0 = 0, dp1 = 0;

    for (let i = 1; i < n; i++) {
        const newDp0 = Math.max(dp0, dp1 + (nums[i] - nums[i - 1]));
        const newDp1 = Math.max(dp1, dp0 + (nums[i] - nums[i - 1]));
        dp0 = newDp0;
        dp1 = newDp1;
    }

    return Math.max(dp0, dp1);
}