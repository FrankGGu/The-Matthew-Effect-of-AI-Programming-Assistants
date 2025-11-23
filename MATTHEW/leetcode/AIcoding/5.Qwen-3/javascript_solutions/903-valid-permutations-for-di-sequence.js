function numPermsDISeq(S) {
    const MOD = 1000000007;
    const n = S.length;
    const dp = new Array(n + 1).fill(0).map(() => new Array(n + 1).fill(0));

    for (let i = 0; i <= n; i++) {
        dp[0][i] = 1;
    }

    for (let i = 1; i <= n; i++) {
        for (let j = 0; j <= i; j++) {
            if (S[i - 1] === 'D') {
                for (let k = j; k < i; k++) {
                    dp[i][j] += dp[i - 1][k];
                    dp[i][j] %= MOD;
                }
            } else {
                for (let k = 0; k < j; k++) {
                    dp[i][j] += dp[i - 1][k];
                    dp[i][j] %= MOD;
                }
            }
        }
    }

    let result = 0;
    for (let i = 0; i <= n; i++) {
        result += dp[n][i];
        result %= MOD;
    }

    return result;
}