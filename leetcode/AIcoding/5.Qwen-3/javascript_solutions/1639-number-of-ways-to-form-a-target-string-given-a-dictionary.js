function numWays(words, target) {
    const MOD = 10 ** 9 + 7;
    const m = words.length;
    const n = words[0].length;
    const k = target.length;

    const count = Array.from({ length: 26 }, () => Array(n).fill(0));

    for (let j = 0; j < n; j++) {
        for (let i = 0; i < m; i++) {
            const c = words[i][j];
            count[c.charCodeAt(0) - 97][j]++;
        }
    }

    const dp = Array(k + 1).fill(0).map(() => Array(n + 1).fill(0));
    dp[0][0] = 1;

    for (let i = 0; i < k; i++) {
        for (let j = 0; j < n; j++) {
            dp[i + 1][j + 1] = (dp[i + 1][j + 1] + dp[i][j] * count[target.charCodeAt(i) - 97][j]) % MOD;
            dp[i + 1][j + 1] = (dp[i + 1][j + 1] + dp[i + 1][j]) % MOD;
        }
    }

    return dp[k][n];
}