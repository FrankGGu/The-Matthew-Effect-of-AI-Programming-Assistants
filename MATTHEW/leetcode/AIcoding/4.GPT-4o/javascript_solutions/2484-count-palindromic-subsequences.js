var countPalindromicSubsequences = function(s) {
    const mod = 1e9 + 7;
    const n = s.length;
    const dp = Array.from(Array(n), () => Array(n).fill(0));

    for (let len = 1; len <= n; len++) {
        for (let i = 0; i <= n - len; i++) {
            const j = i + len - 1;
            if (i === j) {
                dp[i][j] = 1;
            } else if (s[i] === s[j]) {
                let l = i + 1;
                let r = j - 1;

                while (l <= r && s[l] !== s[i]) l++;
                while (l <= r && s[r] !== s[j]) r--;

                if (l > r) {
                    dp[i][j] = dp[i + 1][j - 1] * 2 + 2;
                } else if (l === r) {
                    dp[i][j] = dp[i + 1][j - 1] * 2 + 1;
                } else {
                    dp[i][j] = dp[i + 1][j - 1] * 2 - dp[l + 1][r - 1];
                }
            } else {
                dp[i][j] = (dp[i + 1][j] + dp[i][j - 1] - dp[i + 1][j - 1] + mod) % mod;
            }
        }
    }

    return dp[0][n - 1];
};