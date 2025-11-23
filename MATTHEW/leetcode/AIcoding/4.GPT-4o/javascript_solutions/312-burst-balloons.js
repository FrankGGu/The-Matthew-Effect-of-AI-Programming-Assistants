var maxCoins = function(nums) {
    const n = nums.length;
    const dp = Array.from({length: n + 2}, () => Array(n + 2).fill(0));
    const newNums = [1, ...nums, 1];

    for (let len = 1; len <= n; len++) {
        for (let left = 1; left <= n - len + 1; left++) {
            const right = left + len - 1;
            for (let i = left; i <= right; i++) {
                dp[left][right] = Math.max(dp[left][right], dp[left][i - 1] + dp[i + 1][right] + newNums[left - 1] * newNums[i] * newNums[right + 1]);
            }
        }
    }

    return dp[1][n];
};