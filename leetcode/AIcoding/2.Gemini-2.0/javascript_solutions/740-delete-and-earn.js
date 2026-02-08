var deleteAndEarn = function(nums) {
    const maxVal = Math.max(...nums);
    const sums = new Array(maxVal + 1).fill(0);
    for (const num of nums) {
        sums[num] += num;
    }

    const dp = new Array(maxVal + 1);
    dp[0] = 0;
    dp[1] = sums[1];

    for (let i = 2; i <= maxVal; i++) {
        dp[i] = Math.max(dp[i - 1], dp[i - 2] + sums[i]);
    }

    return dp[maxVal];
};