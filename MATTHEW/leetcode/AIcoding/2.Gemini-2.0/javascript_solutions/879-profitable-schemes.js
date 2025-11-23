var profitableSchemes = function(n, minProfit, group, profit) {
    const MOD = 1000000007;
    const len = group.length;
    const dp = Array(len + 1).fill(null).map(() => Array(n + 1).fill(null).map(() => Array(minProfit + 1).fill(0)));

    dp[0][0][0] = 1;

    for (let i = 1; i <= len; i++) {
        const members = group[i - 1];
        const earn = profit[i - 1];

        for (let j = 0; j <= n; j++) {
            for (let k = 0; k <= minProfit; k++) {
                dp[i][j][k] = dp[i - 1][j][k];

                if (j >= members) {
                    dp[i][j][k] = (dp[i][j][k] + dp[i - 1][j - members][Math.max(0, k - earn)]) % MOD;
                }
            }
        }
    }

    let total = 0;
    for (let j = 0; j <= n; j++) {
        total = (total + dp[len][j][minProfit]) % MOD;
    }

    return total;
};