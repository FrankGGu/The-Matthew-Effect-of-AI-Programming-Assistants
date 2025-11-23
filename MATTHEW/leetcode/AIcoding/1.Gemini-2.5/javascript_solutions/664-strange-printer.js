var strangePrinter = function(s) {
    if (s.length === 0) {
        return 0;
    }

    let newS = "";
    if (s.length > 0) {
        newS += s[0];
        for (let i = 1; i < s.length; i++) {
            if (s[i] !== s[i-1]) {
                newS += s[i];
            }
        }
    }

    s = newS;
    const n = s.length;

    const dp = Array(n).fill(0).map(() => Array(n).fill(0));

    for (let i = 0; i < n; i++) {
        dp[i][i] = 1;
    }

    for (let len = 2; len <= n; len++) {
        for (let i = 0; i <= n - len; i++) {
            const j = i + len - 1;

            dp[i][j] = 1 + dp[i+1][j];

            for (let k = i + 1; k <= j; k++) {
                if (s[k] === s[i]) {
                    const turnsInside = (i + 1 <= k - 1) ? dp[i+1][k-1] : 0;
                    const turnsAfter = (k + 1 <= j) ? dp[k+1][j] : 0;
                    dp[i][j] = Math.min(dp[i][j], turnsInside + turnsAfter);
                }
            }
        }
    }

    return dp[0][n-1];
};