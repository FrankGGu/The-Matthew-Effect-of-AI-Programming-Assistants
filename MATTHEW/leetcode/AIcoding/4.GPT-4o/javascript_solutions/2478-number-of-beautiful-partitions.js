var countPartitions = function(n, k, minProduct) {
    const mod = 1000000007;
    const dp = new Array(n + 1).fill(0);
    dp[0] = 1;

    for (let i = 1; i <= k; i++) {
        for (let j = n; j >= i; j--) {
            dp[j] = (dp[j] + dp[j - i]) % mod;
        }
    }

    let total = 0;

    for (let i = 1; i <= n; i++) {
        if (i >= minProduct) {
            total = (total + dp[i]) % mod;
        }
    }

    return total;
};