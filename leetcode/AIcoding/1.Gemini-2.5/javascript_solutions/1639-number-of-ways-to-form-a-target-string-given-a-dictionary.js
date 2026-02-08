var numWays = function(words, target) {
    const MOD = 10 ** 9 + 7;
    const n = target.length;
    const m = words[0].length;

    const counts = Array(26).fill(0).map(() => Array(m).fill(0));
    for (const word of words) {
        for (let j = 0; j < m; j++) {
            counts[word.charCodeAt(j) - 'a'.charCodeAt(0)][j]++;
        }
    }

    const dp = Array(n + 1).fill(0).map(() => Array(m + 1).fill(0));

    for (let j = 0; j <= m; j++) {
        dp[0][j] = 1;
    }

    for (let i = 1; i <= n; i++) {
        for (let j = 1; j <= m; j++) {
            dp[i][j] = dp[i][j - 1];

            const targetCharIdx = target.charCodeAt(i - 1) - 'a'.charCodeAt(0);
            const waysToPickChar = counts[targetCharIdx][j - 1];

            dp[i][j] = (dp[i][j] + (dp[i - 1][j - 1] * waysToPickChar) % MOD) % MOD;
        }
    }

    return dp[n][m];
};