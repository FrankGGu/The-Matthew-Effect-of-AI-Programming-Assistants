var maxSizeSlices = function(slices) {
    const n = slices.length;
    const k = n / 3;

    function solve(arr) {
        const m = arr.length;
        const dp = Array(m + 1).fill(null).map(() => Array(k + 1).fill(0));

        for (let i = 1; i <= m; i++) {
            for (let j = 1; j <= k; j++) {
                dp[i][j] = Math.max(dp[i - 1][j], (arr[i - 1] + (i >= 2 ? dp[i - 2][j - 1] : 0)));
            }
        }
        return dp[m][k];
    }

    return Math.max(solve(slices.slice(0, n - 1)), solve(slices.slice(1, n)));
};