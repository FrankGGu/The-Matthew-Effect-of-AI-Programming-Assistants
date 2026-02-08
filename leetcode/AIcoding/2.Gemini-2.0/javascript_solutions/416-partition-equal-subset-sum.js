var canPartition = function(nums) {
    const sum = nums.reduce((acc, num) => acc + num, 0);

    if (sum % 2 !== 0) {
        return false;
    }

    const target = sum / 2;
    const n = nums.length;
    const dp = Array(target + 1).fill(false);
    dp[0] = true;

    for (let i = 0; i < n; i++) {
        for (let j = target; j >= nums[i]; j--) {
            dp[j] = dp[j] || dp[j - nums[i]];
        }
    }

    return dp[target];
};