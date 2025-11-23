function minCostToReachEveryPosition(nums) {
    const n = nums.length;
    const cost = new Array(n).fill(0);

    for (let i = 1; i < n; i++) {
        cost[i] = cost[i - 1] + Math.abs(nums[i] - nums[i - 1]);
    }

    for (let i = n - 2; i >= 0; i--) {
        cost[i] = Math.min(cost[i], cost[i + 1] + Math.abs(nums[i] - nums[i + 1]));
    }

    return cost;
}