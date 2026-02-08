var numPermsDISequence = function(S) {
    const MOD = 1000000007;
    const n = S.length;
    const dp = Array(n + 1).fill(0).map(() => Array(n + 1).fill(0));
    dp[0][0] = 1;

    for (let i = 1; i <= n; i++) {
        for (let j = 0; j <= i; j++) {
            if (S[i - 1] === 'D') {
                for (let k = j; k > 0; k--) {
                    dp[i][j] = (dp[i][j] + dp[i - 1][k - 1]) % MOD;
                }
            } else {
                for (let k = 0; k < i; k++) {
                    dp[i][j] = (dp[i][j] + dp[i - 1][k]) % MOD;
                }
            }
        }
    }

    let result = 0;
    for (let j = 0; j <= n; j++) {
        result = (result + dp[n][j]) % MOD;
    }

    return result;
};