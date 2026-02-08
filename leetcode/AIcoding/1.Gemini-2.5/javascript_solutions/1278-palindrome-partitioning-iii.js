var palindromePartition = function(s, k) {
    const n = s.length;

    const cost = Array(n).fill(0).map(() => Array(n).fill(0));

    for (let len = 2; len <= n; len++) {
        for (let i = 0; i <= n - len; i++) {
            let j = i + len - 1;
            cost[i][j] = cost[i + 1][j - 1] + (s[i] === s[j] ? 0 : 1);
        }
    }

    const dp = Array(n + 1).fill(0).map(() => Array(k + 1).fill(Infinity));

    dp[0][0] = 0;

    for (let j = 1; j <= k; j++) {
        for (let i = 1; i <= n; i++) {
            if (i < j) {
                continue;
            }

            for (let p = j - 1; p < i; p++) {
                if (dp[p][j - 1] !== Infinity) {
                    dp[i][j] = Math.min(dp[i][j], dp[p][j - 1] + cost[p][i - 1]);
                }
            }
        }
    }

    return dp[n][k];
};