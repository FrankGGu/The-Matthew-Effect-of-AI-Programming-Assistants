function deleteAndEarn(n, nums) {
    const maxNum = Math.max(...nums);
    const count = new Array(maxNum + 1).fill(0);

    for (const num of nums) {
        count[num]++;
    }

    const dp = new Array(maxNum + 1).fill(0);
    dp[0] = 0;
    dp[1] = count[1] * 1;

    for (let i = 2; i <= maxNum; i++) {
        dp[i] = Math.max(dp[i - 1], dp[i - 2] + count[i] * i);
    }

    return dp[maxNum];
}