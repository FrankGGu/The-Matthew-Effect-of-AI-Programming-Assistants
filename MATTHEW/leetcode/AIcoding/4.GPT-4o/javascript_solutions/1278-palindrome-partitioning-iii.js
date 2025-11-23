var palindromePartition = function(s, k) {
    const n = s.length;
    const dp = Array.from({ length: n + 1 }, () => Array(k + 1).fill(Infinity));
    const palin = Array.from({ length: n }, () => Array(n).fill(0));

    for (let i = 0; i < n; i++) {
        palin[i][i] = 1;
        for (let j = i + 1; j < n; j++) {
            if (s[i] === s[j]) {
                palin[i][j] = palin[i + 1][j - 1];
            } else {
                palin[i][j] = palin[i + 1][j - 1] + 1;
            }
        }
    }

    for (let i = 0; i <= n; i++) {
        dp[i][1] = palin[0][i - 1];
    }

    for (let j = 2; j <= k; j++) {
        for (let i = j; i <= n; i++) {
            for (let p = j - 1; p < i; p++) {
                dp[i][j] = Math.min(dp[i][j], dp[p][j - 1] + palin[p][i - 1]);
            }
        }
    }

    return dp[n][k];
};