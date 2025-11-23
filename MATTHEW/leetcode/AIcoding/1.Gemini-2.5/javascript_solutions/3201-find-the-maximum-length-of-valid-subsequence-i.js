var maxLength = function(nums) {
    let dp = [0, 0]; // dp[0] for even-ending, dp[1] for odd-ending

    for (let i = 0; i < nums.length; i++) {
        const num = nums[i];
        if (num % 2 === 0) { // Current number is even
            dp[0] = Math.max(dp[1] + 1, 1);
        } else { // Current number is odd
            dp[1] = Math.max(dp[0] + 1, 1);
        }
    }

    return Math.max(dp[0], dp[1]);
};