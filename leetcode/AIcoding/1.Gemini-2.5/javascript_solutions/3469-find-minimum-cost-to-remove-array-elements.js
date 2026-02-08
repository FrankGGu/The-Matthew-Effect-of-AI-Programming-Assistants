var minimumCost = function(nums) {
    nums.sort((a, b) => a - b);

    let totalCost = 0;
    const n = nums.length;

    for (let i = 0; i < n; i++) {
        totalCost += nums[i] * (n - i);
    }

    return totalCost;
};