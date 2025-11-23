function maxSumAfterPartitioning(arr, k) {
    const n = arr.length;
    const dp = new Array(n).fill(0);

    for (let i = 0; i < n; i++) {
        let maxVal = 0;
        for (let j = i; j >= Math.max(0, i - k + 1); j--) {
            maxVal = Math.max(maxVal, arr[j]);
            dp[i] = Math.max(dp[i], dp[j - 1] + maxVal * (i - j + 1));
        }
    }

    return dp[n - 1];
}