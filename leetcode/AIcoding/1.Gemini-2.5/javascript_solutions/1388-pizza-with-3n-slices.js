var maxSizeSlices = function(slices) {
    const totalSlices = slices.length;
    const k = totalSlices / 3;

    function solve(arr, k_to_pick) {
        const m = arr.length;
        const dp = Array(k_to_pick + 1).fill(0).map(() => Array(m).fill(0));

        dp[1][0] = arr[0];
        for (let i = 1; i < m; i++) {
            dp[1][i] = Math.max(arr[i], dp[1][i - 1]);
        }

        for (let j = 2; j <= k_to_pick; j++) {
            for (let i = 1; i < m; i++) {
                dp[j][i] = dp[j][i - 1];
                if (i >= 2) {
                    dp[j][i] = Math.max(dp[j][i], dp[j - 1][i - 2] + arr[i]);
                }
            }
        }

        return dp[k_to_pick][m - 1];
    }

    const slicesWithoutLast = slices.slice(0, totalSlices - 1);
    const result1 = solve(slicesWithoutLast, k);

    const slicesWithoutFirst = slices.slice(1);
    const result2 = solve(slicesWithoutFirst, k);

    return Math.max(result1, result2);
};