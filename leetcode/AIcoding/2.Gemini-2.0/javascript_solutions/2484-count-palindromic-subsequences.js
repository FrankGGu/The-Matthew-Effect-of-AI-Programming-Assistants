var countPalindromicSubsequences = function(s) {
    const MOD = 1000000007;
    const n = s.length;
    const dp = Array(n).fill(null).map(() => Array(n).fill(0));

    for (let i = 0; i < n; i++) {
        dp[i][i] = 1;
    }

    for (let len = 2; len <= n; len++) {
        for (let i = 0; i <= n - len; i++) {
            let j = i + len - 1;
            if (s[i] === s[j]) {
                let low = i + 1;
                let high = j - 1;

                while (low <= high && s[low] !== s[i]) {
                    low++;
                }
                while (low <= high && s[high] !== s[i]) {
                    high--;
                }

                if (low > high) {
                    dp[i][j] = (2 * dp[i + 1][j - 1] + 2) % MOD;
                } else if (low === high) {
                    dp[i][j] = (2 * dp[i + 1][j - 1] + 1) % MOD;
                } else {
                    dp[i][j] = (2 * dp[i + 1][j - 1] - dp[low + 1][high - 1] + MOD) % MOD;
                }
            } else {
                dp[i][j] = (dp[i][j - 1] + dp[i + 1][j] - dp[i + 1][j - 1] + MOD) % MOD;
            }
        }
    }

    return dp[0][n - 1];
};