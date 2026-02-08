const distinctSequences = (n) => {
    const MOD = 1e9 + 7;
    const dp = Array.from({ length: n + 1 }, () => Array(7).fill(0));

    for (let j = 1; j <= 6; j++) {
        dp[1][j] = 1;
    }

    for (let i = 2; i <= n; i++) {
        for (let j = 1; j <= 6; j++) {
            for (let k = 1; k <= 6; k++) {
                if (j !== k && (j + k) !== 7) {
                    dp[i][j] = (dp[i][j] + dp[i - 1][k]) % MOD;
                }
            }
        }
    }

    let result = 0;
    for (let j = 1; j <= 6; j++) {
        result = (result + dp[n][j]) % MOD;
    }

    return result;
};