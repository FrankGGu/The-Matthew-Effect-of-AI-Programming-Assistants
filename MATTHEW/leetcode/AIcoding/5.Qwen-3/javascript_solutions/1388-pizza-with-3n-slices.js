function mostSlices(slices) {
    const n = slices.length / 3;

    function helper(arr, start, end) {
        const m = end - start + 1;
        const dp = new Array(m).fill(0);

        for (let i = 0; i < m; i++) {
            dp[i] = arr[start + i];
        }

        for (let i = 2; i <= n; i++) {
            for (let j = m - 1; j >= i * 2 - 1; j--) {
                dp[j] = Math.max(dp[j], dp[j - 2] + arr[start + j]);
            }
        }

        return dp[m - 1];
    }

    return Math.max(helper(slices, 0, slices.length - 2), helper(slices, 1, slices.length - 1));
}