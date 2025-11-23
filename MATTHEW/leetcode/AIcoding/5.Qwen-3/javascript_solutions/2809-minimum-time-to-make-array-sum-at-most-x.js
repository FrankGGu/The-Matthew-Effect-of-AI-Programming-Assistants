function minTimeToMakeSumAtMostX(power, x) {
    const n = power.length;
    const dp = new Array(n + 1).fill(0);
    for (let i = 1; i <= n; i++) {
        dp[i] = dp[i - 1] + power[i - 1];
    }
    for (let i = 1; i <= n; i++) {
        for (let j = i; j >= 1; j--) {
            dp[j] = Math.min(dp[j], dp[j - 1] + power[i - 1]);
        }
    }
    for (let i = 1; i <= n; i++) {
        if (dp[i] <= x) {
            return i;
        }
    }
    return n;
}