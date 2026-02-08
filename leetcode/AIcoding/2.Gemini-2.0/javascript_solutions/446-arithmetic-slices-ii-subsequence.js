var numberOfArithmeticSlices = function(nums) {
    const n = nums.length;
    let dp = new Array(n).fill(null).map(() => new Map());
    let ans = 0;

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < i; j++) {
            let diff = nums[i] - nums[j];
            if (diff > Number.MAX_SAFE_INTEGER || diff < Number.MIN_SAFE_INTEGER) {
                continue;
            }

            let count = dp[j].get(diff) || 0;
            ans += count;
            dp[i].set(diff, (dp[i].get(diff) || 0) + count + 1);
        }
    }

    return ans;
};