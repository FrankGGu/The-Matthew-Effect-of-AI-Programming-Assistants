var numberOfArithmeticSlices = function(nums) {
    const n = nums.length;
    let total = 0;
    const dp = new Array(n).fill().map(() => new Map());

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < i; j++) {
            const diff = nums[i] - nums[j];
            const count = dp[j].get(diff) || 0;
            total += count;
            dp[i].set(diff, (dp[i].get(diff) || 0) + count + 1));
        }
    }

    return total;
};