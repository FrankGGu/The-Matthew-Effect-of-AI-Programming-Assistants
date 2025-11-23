function burstBalloons(nums) {
    const n = nums.length;
    const dp = Array(n).fill().map(() => Array(n).fill(0));

    for (let length = 1; length <= n; length++) {
        for (let i = 0; i <= n - length; i++) {
            const j = i + length - 1;
            for (let k = i; k <= j; k++) {
                const left = (i === 0) ? 0 : nums[i - 1];
                const right = (j === n - 1) ? 0 : nums[j + 1];
                const current = nums[k] * left * right;
                const leftPart = (k === i) ? 0 : dp[i][k - 1];
                const rightPart = (k === j) ? 0 : dp[k + 1][j];
                dp[i][j] = Math.max(dp[i][j], leftPart + rightPart + current);
            }
        }
    }

    return dp[0][n - 1];
}