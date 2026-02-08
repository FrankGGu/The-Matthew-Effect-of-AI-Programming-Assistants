function minCost(houses, cost, k) {
    const n = houses.length;
    const dp = Array.from({ length: k + 1 }, () => Array(n).fill(Infinity));
    dp[0][0] = 0;

    for (let i = 1; i <= k; i++) {
        for (let j = 0; j < n; j++) {
            for (let m = 0; m < j; m++) {
                if (dp[i - 1][m] === Infinity) continue;
                let currentCost = 0;
                for (let l = m + 1; l <= j; l++) {
                    currentCost += Math.abs(houses[l] - houses[m]);
                }
                dp[i][j] = Math.min(dp[i][j], dp[i - 1][m] + currentCost);
            }
        }
    }

    let result = Infinity;
    for (let i = 0; i < n; i++) {
        result = Math.min(result, dp[k][i]);
    }

    return result;
}