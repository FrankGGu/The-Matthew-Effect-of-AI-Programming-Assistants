var numWays = function(words, target) {
    const mod = 1e9 + 7;
    const m = words[0].length;
    const n = target.length;
    const count = Array.from({ length: m }, () => new Array(26).fill(0));

    for (const word of words) {
        for (let i = 0; i < m; i++) {
            const c = word.charCodeAt(i) - 'a'.charCodeAt(0);
            count[i][c]++;
        }
    }

    const dp = Array.from({ length: m + 1 }, () => new Array(n + 1).fill(0));
    dp[0][0] = 1;

    for (let i = 0; i <= m; i++) {
        dp[i][0] = 1;
    }

    for (let i = 1; i <= m; i++) {
        for (let j = 1; j <= n; j++) {
            const c = target.charCodeAt(j - 1) - 'a'.charCodeAt(0);
            dp[i][j] = (dp[i - 1][j] + dp[i - 1][j - 1] * count[i - 1][c]) % mod;
        }
    }

    return dp[m][n];
};