var deleteString = function(s) {
    const n = s.length;
    const dp = new Array(n).fill(1);

    for (let i = n - 1; i >= 0; i--) {
        for (let l = 1; i + 2 * l <= n; l++) {
            const j = i + l;
            if (s.substring(i, i + l) === s.substring(j, j + l)) {
                dp[i] = Math.max(dp[i], dp[j] + 1);
            }
        }
    }

    return dp[0];
};