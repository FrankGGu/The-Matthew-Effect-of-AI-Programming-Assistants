var maxPalindromes = function(s, k) {
    const n = s.length;

    const isP = Array(n).fill(0).map(() => Array(n).fill(false));

    for (let len = 1; len <= n; len++) {
        for (let i = 0; i <= n - len; i++) {
            const j = i + len - 1;

            if (s[i] === s[j]) {
                if (len <= 2) {
                    isP[i][j] = true;
                } else {
                    isP[i][j] = isP[i + 1][j - 1];
                }
            }
        }
    }

    const dp = Array(n + 1).fill(0);

    for (let i = 1; i <= n; i++) {
        dp[i] = dp[i - 1];

        for (let j = 0; j <= i - k; j++) {
            if (isP[j][i - 1]) {
                dp[i] = Math.max(dp[i], dp[j] + 1);
            }
        }
    }

    return dp[n];
};