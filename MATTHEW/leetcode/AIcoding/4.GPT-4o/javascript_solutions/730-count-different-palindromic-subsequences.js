var countPalindromes = function(s) {
    const mod = 1e9 + 7;
    const n = s.length;
    let dp = Array.from({ length: n }, () => Array(n).fill(0));

    for (let i = 0; i < n; i++) {
        dp[i][i] = 1;
    }

    for (let len = 2; len <= n; len++) {
        for (let i = 0; i <= n - len; i++) {
            const j = i + len - 1;
            if (s[i] === s[j]) {
                let low = i + 1, high = j - 1;
                while (low <= high && s[low] !== s[i]) low++;
                while (low <= high && s[high] !== s[j]) high--;
                if (low > high) {
                    dp[i][j] = dp[i + 1][j - 1] * 2 + 2;
                } else if (low === high) {
                    dp[i][j] = dp[i + 1][j - 1] * 2 + 1;
                } else {
                    dp[i][j] = dp[i + 1][j - 1] * 2 - dp[low + 1][high - 1];
                }
            } else {
                dp[i][j] = (dp[i + 1][j] + dp[i][j - 1] - dp[i + 1][j - 1] + mod) % mod;
            }
        }
    }

    return dp[0][n - 1];
};