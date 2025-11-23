var numberOfWays = function(s) {
    const n = s.length;
    const mod = 10**9 + 7;
    const dp = Array(n + 1).fill(0);
    dp[0] = 1;

    for (let i = 1; i <= n; i++) {
        for (let j = 1; j <= i; j++) {
            if (s[i - j] === '0') continue;
            if (j > i - j) {
                dp[i] = (dp[i] + dp[i - j]) % mod;
            } else if (j === i - j) {
                dp[i] = (dp[i] + dp[i - j]) % mod;
            } else {
                let left = s.substring(i - 2 * j, i - j);
                let right = s.substring(i - j, i);
                if (left <= right) {
                    dp[i] = (dp[i] + dp[i - j]) % mod;
                }
            }
        }
    }

    return dp[n];
};