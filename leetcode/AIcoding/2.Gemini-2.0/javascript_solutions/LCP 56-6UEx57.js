var transmitProperties = function(properties, k) {
    const n = properties.length;
    const dp = Array(n).fill(0);
    dp[0] = 1;

    for (let i = 0; i < k; i++) {
        const nextDp = Array(n).fill(0);
        for (let j = 0; j < n; j++) {
            nextDp[j] = (dp[(j - 1 + n) % n] + dp[(j + 1) % n]) % 1000000007;
        }
        dp.splice(0, n, ...nextDp);
    }

    return dp[0];
};