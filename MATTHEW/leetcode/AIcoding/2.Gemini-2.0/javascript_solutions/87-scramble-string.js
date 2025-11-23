var isScramble = function(s1, s2) {
    if (s1.length !== s2.length) return false;
    if (s1 === s2) return true;

    const n = s1.length;
    const dp = Array(n + 1).fill(null).map(() => Array(n).fill(null).map(() => Array(n).fill(false)));

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            dp[1][i][j] = s1[i] === s2[j];
        }
    }

    for (let len = 2; len <= n; len++) {
        for (let i = 0; i <= n - len; i++) {
            for (let j = 0; j <= n - len; j++) {
                for (let k = 1; k < len; k++) {
                    if ((dp[k][i][j] && dp[len - k][i + k][j + k]) || (dp[k][i][j + len - k] && dp[len - k][i + k][j])) {
                        dp[len][i][j] = true;
                        break;
                    }
                }
            }
        }
    }

    return dp[n][0][0];
};