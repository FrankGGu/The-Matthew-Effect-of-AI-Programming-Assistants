function minimizeMaxDiff(arr, k) {
    const n = arr.length;
    const dp = new Array(n).fill(0).map(() => new Array(k + 1).fill(0));

    for (let i = 0; i < n; i++) {
        dp[i][0] = 0;
    }

    for (let j = 1; j <= k; j++) {
        for (let i = 0; i < n; i++) {
            dp[i][j] = Number.MAX_VALUE;
            for (let m = 0; m < i; m++) {
                dp[i][j] = Math.min(dp[i][j], Math.max(dp[m][j - 1], arr[i] - arr[m]));
            }
        }
    }

    return dp[n - 1][k];
}