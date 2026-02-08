var profitableSchemes = function(G, P, group, profit) {
    const MOD = 1e9 + 7;
    const dp = Array.from({ length: G + 1 }, () => Array(P + 1).fill(0));
    dp[0][0] = 1;

    for (let i = 0; i < group.length; i++) {
        const g = group[i], p = profit[i];
        for (let j = G; j >= g; j--) {
            for (let k = P; k >= 0; k--) {
                dp[j][Math.min(k + p, P)] = (dp[j][Math.min(k + p, P)] + dp[j - g][k]) % MOD;
            }
        }
    }

    let result = 0;
    for (let j = 0; j <= G; j++) {
        for (let k = P; k <= P; k++) {
            result = (result + dp[j][k]) % MOD;
        }
    }

    return result;
};