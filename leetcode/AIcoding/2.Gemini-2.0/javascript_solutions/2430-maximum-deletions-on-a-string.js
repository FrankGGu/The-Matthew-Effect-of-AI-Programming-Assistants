var deleteString = function(s) {
    const n = s.length;
    const lcp = Array(n).fill(null).map(() => Array(n).fill(0));

    for (let i = n - 1; i >= 0; i--) {
        for (let j = n - 1; j >= 0; j--) {
            if (s[i] === s[j]) {
                lcp[i][j] = (i + 1 < n && j + 1 < n) ? lcp[i + 1][j + 1] + 1 : 1;
            } else {
                lcp[i][j] = 0;
            }
        }
    }

    const dp = Array(n).fill(0);
    for (let i = n - 1; i >= 0; i--) {
        dp[i] = 1;
        for (let j = 1; i + j < n; j++) {
            if (lcp[i][i + j] >= j) {
                dp[i] = Math.max(dp[i], dp[i + j] + 1);
            }
        }
    }

    return dp[0];
};