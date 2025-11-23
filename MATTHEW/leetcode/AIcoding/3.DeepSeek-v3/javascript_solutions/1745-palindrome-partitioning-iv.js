var checkPartitioning = function(s) {
    const n = s.length;
    const dp = Array.from({ length: n }, () => Array(n).fill(false));

    for (let i = n - 1; i >= 0; i--) {
        for (let j = i; j < n; j++) {
            if (s[i] === s[j] && (j - i <= 2 || dp[i + 1][j - 1])) {
                dp[i][j] = true;
            }
        }
    }

    for (let i = 1; i < n - 1; i++) {
        for (let j = i; j < n - 1; j++) {
            if (dp[0][i - 1] && dp[i][j] && dp[j + 1][n - 1]) {
                return true;
            }
        }
    }

    return false;
};