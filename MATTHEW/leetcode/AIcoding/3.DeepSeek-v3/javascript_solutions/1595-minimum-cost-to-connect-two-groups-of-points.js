var connectTwoGroups = function(cost) {
    const size1 = cost.length;
    const size2 = cost[0].length;
    const m = 1 << size2;
    const dp = Array.from({ length: size1 + 1 }, () => new Array(m).fill(Infinity));
    dp[0][0] = 0;

    for (let i = 1; i <= size1; ++i) {
        for (let mask = 0; mask < m; ++mask) {
            for (let j = 0; j < size2; ++j) {
                const newMask = mask | (1 << j);
                dp[i][newMask] = Math.min(dp[i][newMask], dp[i - 1][mask] + cost[i - 1][j]);
                dp[i][newMask] = Math.min(dp[i][newMask], dp[i][mask] + cost[i - 1][j]);
            }
        }
    }

    return dp[size1][m - 1];
};