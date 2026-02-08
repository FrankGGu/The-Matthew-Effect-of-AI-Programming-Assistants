class Solution {
    maximizeTheCuts(n, x, y, z) {
        const dp = new Array(n + 1).fill(0);
        for (let i = 1; i <= n; i++) {
            if (i >= x) dp[i] = Math.max(dp[i], dp[i - x] + 1);
            if (i >= y) dp[i] = Math.max(dp[i], dp[i - y] + 1);
            if (i >= z) dp[i] = Math.max(dp[i], dp[i - z] + 1);
        }
        return dp[n];
    }
}