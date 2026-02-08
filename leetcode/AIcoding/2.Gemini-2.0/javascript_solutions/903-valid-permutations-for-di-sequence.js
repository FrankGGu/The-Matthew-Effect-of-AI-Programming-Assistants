var numPermsDISequence = function(s) {
    const n = s.length;
    const MOD = 10**9 + 7;
    let dp = Array(n + 1).fill(0).map(() => Array(n + 1).fill(0));

    for (let j = 0; j <= n; j++) {
        dp[0][j] = 1;
    }

    for (let i = 1; i <= n; i++) {
        for (let j = 0; j <= n - i; j++) {
            if (s[i - 1] === 'I') {
                for (let k = 0; k < j; k++) {
                    dp[i][j] = (dp[i][j] + dp[i - 1][k]) % MOD;
                }
            } else {
                for (let k = j; k <= n - i; k++) {
                    dp[i][j] = (dp[i][j] + dp[i - 1][k]) % MOD;
                }
            }
        }
    }

    let ans = 0;
    for (let j = 0; j <= n; j++) {
        ans = (ans + dp[n][j]) % MOD;
    }

    return ans;
};