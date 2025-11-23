var minCut = function(s) {
    const n = s.length;
    const dp = new Array(n).fill(0).map(() => new Array(n).fill(true));

    for (let i = n - 1; i >= 0; i--) {
        for (let j = i + 1; j < n; j++) {
            dp[i][j] = (s[i] === s[j]) && dp[i + 1][j - 1];
        }
    }

    const f = new Array(n).fill(Infinity);
    for (let i = 0; i < n; i++) {
        if (dp[0][i]) {
            f[i] = 0;
        } else {
            for (let j = 0; j < i; j++) {
                if (dp[j + 1][i]) {
                    f[i] = Math.min(f[i], f[j] + 1);
                }
            }
        }
    }

    return f[n - 1];
};