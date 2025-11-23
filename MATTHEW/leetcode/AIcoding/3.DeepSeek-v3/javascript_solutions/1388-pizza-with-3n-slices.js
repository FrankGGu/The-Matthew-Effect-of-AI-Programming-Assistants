var maxSizeSlices = function(slices) {
    const n = slices.length / 3;

    const helper = (arr, k) => {
        const m = arr.length;
        const dp = Array.from({ length: m + 1 }, () => new Array(k + 1).fill(0));

        for (let i = 1; i <= m; i++) {
            for (let j = 1; j <= k; j++) {
                if (i === 1) {
                    dp[i][j] = arr[0];
                } else {
                    dp[i][j] = Math.max(dp[i - 1][j], dp[i - 2][j - 1] + arr[i - 1]);
                }
            }
        }
        return dp[m][k];
    };

    const case1 = helper(slices.slice(0, slices.length - 1), n);
    const case2 = helper(slices.slice(1, slices.length), n);

    return Math.max(case1, case2);
};