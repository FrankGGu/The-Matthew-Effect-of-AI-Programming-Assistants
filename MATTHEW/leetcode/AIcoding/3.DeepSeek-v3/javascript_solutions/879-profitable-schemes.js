var profitableSchemes = function(n, minProfit, group, profit) {
    const MOD = 1e9 + 7;
    const dp = new Array(n + 1).fill().map(() => new Array(minProfit + 1).fill(0));
    dp[0][0] = 1;

    for (let k = 0; k < group.length; k++) {
        const g = group[k];
        const p = profit[k];
        for (let i = n; i >= g; i--) {
            for (let j = minProfit; j >= 0; j--) {
                const newProfit = Math.min(j + p, minProfit);
                dp[i][newProfit] = (dp[i][newProfit] + dp[i - g][j]) % MOD;
            }
        }
    }

    let result = 0;
    for (let i = 0; i <= n; i++) {
        result = (result + dp[i][minProfit]) % MOD;
    }

    return result;
};