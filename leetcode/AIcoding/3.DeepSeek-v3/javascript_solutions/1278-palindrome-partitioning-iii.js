var palindromePartition = function(s, k) {
    const n = s.length;
    const cost = Array.from({ length: n }, () => Array(n).fill(0));
    for (let len = 2; len <= n; len++) {
        for (let i = 0; i <= n - len; i++) {
            const j = i + len - 1;
            cost[i][j] = cost[i + 1][j - 1] + (s[i] !== s[j] ? 1 : 0);
        }
    }

    const dp = Array.from({ length: n + 1 }, () => Array(k + 1).fill(Infinity));
    dp[0][0] = 0;
    for (let i = 1; i <= n; i++) {
        for (let j = 1; j <= Math.min(i, k); j++) {
            if (j === 1) {
                dp[i][j] = cost[0][i - 1];
            } else {
                for (let m = j - 1; m < i; m++) {
                    dp[i][j] = Math.min(dp[i][j], dp[m][j - 1] + cost[m][i - 1]);
                }
            }
        }
    }
    return dp[n][k];
};