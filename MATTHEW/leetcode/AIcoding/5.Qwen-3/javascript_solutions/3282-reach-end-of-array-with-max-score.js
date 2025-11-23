function maxScore(arr, k) {
    const n = arr.length;
    const dp = new Array(n).fill(0);
    dp[0] = arr[0];

    for (let i = 1; i < n; i++) {
        let maxVal = -Infinity;
        for (let j = 1; j <= k && i - j >= 0; j++) {
            maxVal = Math.max(maxVal, dp[i - j]);
        }
        dp[i] = maxVal + arr[i];
    }

    return dp[n - 1];
}