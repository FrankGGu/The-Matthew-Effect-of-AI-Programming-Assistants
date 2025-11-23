var countPalindromicSubsequences = function(s) {
    const MOD = 1e9 + 7;
    const n = s.length;
    const dp = Array.from({ length: n }, () => Array(n).fill(0));

    for (let i = 0; i < n; i++) {
        dp[i][i] = 1;
    }

    for (let len = 2; len <= n; len++) {
        for (let i = 0; i <= n - len; i++) {
            const j = i + len - 1;
            if (s[i] === s[j]) {
                let left = i + 1;
                let right = j - 1;
                while (left <= right && s[left] !== s[i]) left++;
                while (left <= right && s[right] !== s[i]) right--;

                if (left > right) {
                    dp[i][j] = dp[i + 1][j - 1] * 2 + 2;
                } else if (left === right) {
                    dp[i][j] = dp[i + 1][j - 1] * 2 + 1;
                } else {
                    dp[i][j] = dp[i + 1][j - 1] * 2 - dp[left + 1][right - 1];
                }
            } else {
                dp[i][j] = dp[i][j - 1] + dp[i + 1][j] - dp[i + 1][j - 1];
            }
            dp[i][j] = dp[i][j] < 0 ? dp[i][j] + MOD : dp[i][j] % MOD;
        }
    }

    return dp[0][n - 1];
};