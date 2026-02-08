var longestArithSeqLength = function(nums) {
    const n = nums.length;
    if (n <= 2) {
        return n;
    }

    let dp = Array(n).fill(null).map(() => ({}));
    let maxLength = 2;

    for (let i = 1; i < n; i++) {
        for (let j = 0; j < i; j++) {
            const diff = nums[i] - nums[j];
            if (dp[j][diff] !== undefined) {
                dp[i][diff] = dp[j][diff] + 1;
            } else {
                dp[i][diff] = 2;
            }
            maxLength = Math.max(maxLength, dp[i][diff]);
        }
    }

    return maxLength;
};