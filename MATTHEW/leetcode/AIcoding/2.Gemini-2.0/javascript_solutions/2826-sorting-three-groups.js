var minimumOperations = function(nums) {
    const n = nums.length;
    let dp = Array(4).fill(0);

    for (let i = 0; i < n; i++) {
        let new_dp = Array(4).fill(0);
        new_dp[1] = dp[1];
        new_dp[2] = Math.min(dp[1], dp[2]);
        new_dp[3] = Math.min(dp[1], Math.min(dp[2], dp[3]));

        if (nums[i] === 1) {
            new_dp[1]++;
        } else if (nums[i] === 2) {
            new_dp[2]++;
        } else {
            new_dp[3]++;
        }

        dp = new_dp;
    }

    return n - Math.max(dp[1], Math.max(dp[2], dp[3]));
};