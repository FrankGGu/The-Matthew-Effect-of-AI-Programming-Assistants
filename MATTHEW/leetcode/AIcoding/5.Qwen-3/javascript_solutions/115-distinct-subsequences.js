function numDistinct(S, T) {
    const m = S.length;
    const n = T.length;
    const dp = new Array(n + 1).fill(0);
    dp[0] = 1;
    for (let i = 1; i <= m; i++) {
        for (let j = n; j >= 1; j--) {
            if (S[i - 1] === T[j - 1]) {
                dp[j] = (dp[j] + dp[j - 1]) % (10 ** 9 + 7);
            }
        }
    }
    return dp[n];
}