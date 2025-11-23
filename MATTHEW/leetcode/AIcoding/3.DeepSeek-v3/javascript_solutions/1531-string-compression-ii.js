var getLengthOfOptimalCompression = function(s, k) {
    const n = s.length;
    const dp = Array.from({ length: n + 1 }, () => Array(k + 1).fill(Infinity));
    dp[0][0] = 0;

    for (let i = 1; i <= n; i++) {
        for (let j = 0; j <= k; j++) {
            if (j > 0) {
                dp[i][j] = dp[i - 1][j - 1];
            }
            let same = 0, diff = 0;
            for (let m = i; m >= 1; m--) {
                if (s[m - 1] === s[i - 1]) {
                    same++;
                } else {
                    diff++;
                }
                if (diff > j) break;
                const len = same === 1 ? 1 : (same < 10 ? 2 : (same < 100 ? 3 : 4));
                dp[i][j] = Math.min(dp[i][j], dp[m - 1][j - diff] + len);
            }
        }
    }
    return dp[n][k];
};